{ pkgs, lib, config, inputs, ... }:
let
  inherit (lib.types) nullOr str listOf bool;

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
      lazygit
      # TODO: this should be temporary
      inputs.ballsvim.packages.x86_64-linux.nvim
    ];
  };
}
