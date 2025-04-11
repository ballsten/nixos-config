{
  nix-config,
  pkgs,
  lib,
  config,
  ...
}:

let
  inherit (lib.types) nullOr str listOf;
  inherit (config.boot) isContainer;

  inherit (lib)
    mkOption
    mkEnableOption
    mkIf
    singleton
    optional
    ;

  inherit (cfg)
    username
    hashedPassword
    ;

  cfg = config.modules.system;
in
{
  imports = with nix-config.inputs.home-manager.nixosModules; [ home-manager ];

  options.modules.system = {
    username = mkOption {
      type = str;
      default = "user";
    };

    hashedPassword = mkOption {
      type = nullOr str;
      default = null;
    };

    timeZone = mkOption {
      type = str;
      default = "Australia/Sydney";
    };

    defaultLocale = mkOption {
      type = str;
      default = "en_US.UTF-8";
    };

    supportedLocales = mkOption {
      type = listOf str;

      default = [
        "en_US.UTF-8/UTF-8"
      ];
    };

    stateVersion = mkOption {
      type = str;
      default = "24.11";
    };

    hostName = mkOption {
      type = str;
      default = "nixos";
    };
  };

  config = {
    boot = {
      loader = {
        systemd-boot = {
          enable = true;
          editor = false;
          configurationLimit = 10;
        };

        timeout = 5;
        efi.canTouchEfiVariables = true;
      };

      blacklistedKernelModules = [ "floppy" ];
    };

    nix = {
      settings = {
        auto-optimise-store = true;
        warn-dirty = false;
        allow-import-from-derivation = false;
        keep-going = true;

        experimental-features = [
          "nix-command"
          "flakes"
        ];

        trusted-users = [
          "root"
          "@wheel"
        ];
      };
    };

    time = {
      inherit (cfg) timeZone;
    };

    i18n = {
      inherit (cfg) defaultLocale supportedLocales;
    };

    system = {
      inherit (cfg) stateVersion;
    };

    users = {
      mutableUsers = false;

      users.${username} = {
        inherit hashedPassword;

        isNormalUser = true;
        uid = 1000;

        extraGroups =
            [
              "wheel"
              "networkmanager"
            ];
      };
    };

    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;

      sharedModules = singleton {
        home = {
          inherit (cfg) stateVersion;
        };

        programs.man.generateCaches = true;
      };

      users.${username}.home = {
        inherit username;

        homeDirectory = "/home/${username}";
      };
    };

    networking = {
      inherit (cfg) hostName;

      networkmanager = {
        enable = true;
      };
    };

    security.sudo.wheelNeedsPassword = false;

    # TODO: Come back to this
    #  environment = {
    #  systemPackages = with pkgs; [ (pass.withExtensions (ext: with ext; [ pass-otp ])) ];
    #  gnome.excludePackages = with pkgs; [ gnome-tour ];
    # };

    environment.systemPackages = with pkgs; [
      vim
      git
      # TODO: this should be temporary
      nix-config.inputs.ballsvim.packages.x86_64-linux.nvim
    ];
  };
}
