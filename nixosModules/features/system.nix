{
  pkgs,
  lib,
  config,
  inputs,
  ...
}:
let
  inherit (cfg)
    username
    hashedPassword
    ;

  cfg = config.myNixOS.features.system;
in
{
  options.myNixOS.features.system = {
    username = lib.mkOption {
      type = lib.types.str;
      default = "user";
    };

    hashedPassword = lib.mkOption {
      type = lib.types.nullOr lib.types.str;
      default = null;
    };

    timeZone = lib.mkOption {
      type = lib.types.str;
      default = "Australia/Sydney";
    };

    defaultLocale = lib.mkOption {
      type = lib.types.str;
      default = "en_US.UTF-8";
    };

    supportedLocales = lib.mkOption {
      type = lib.types.listOf lib.types.str;

      default = [
        "en_US.UTF-8/UTF-8"
      ];
    };

    stateVersion = lib.mkOption {
      type = lib.types.str;
      default = "24.11";
    };

    hostName = lib.mkOption {
      type = lib.types.str;
      default = "nixos";
    };

    shell = lib.mkOption {
      type = lib.types.enum (
        with pkgs;
        [
          bash
          fish
        ]
      );
      default = pkgs.bash;
      description = ''
        Set the shell for this user
      '';
    };
  };

  config = {
    # TODO: make this better
    boot = {
      loader = {
        systemd-boot = {
          enable = lib.mkDefault true;
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

    # enable the correct shell
    # bash is always enabled
    programs = {
      fish.enable = lib.mkIf (cfg.shell == pkgs.fish) true;
    };

    users = {
      mutableUsers = false;

      users.${username} = {
        inherit hashedPassword;

        shell = cfg.shell;

        isNormalUser = true;
        uid = 1000;

        extraGroups = [
          "wheel"
          "networkmanager"
        ];
      };
    };

    networking = {
      inherit (cfg) hostName;

      networkmanager = {
        enable = true;
      };
    };

    security.sudo.wheelNeedsPassword = false;

    environment.systemPackages = with pkgs; [
      vim
      git
      # TODO: this should be temporary
      inputs.ballsvim.packages.x86_64-linux.ballsvim
    ];
  };
}
