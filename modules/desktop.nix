
{
  pkgs,
  config,
  lib,
  ...
}:

let
  inherit (lib.types) bool;
  inherit (lib)
    mkOption
    mkEnableOption
    mkDefault
    mkIf
    mkMerge
    ;

  cfg = config.modules;
in
{
  options.modules.desktop = {
    enabled = mkOption {
      type = bool;
      default = false;
    };
  };

  config = mkIf (cfg.desktop.enabled) {
    # TODO: what is this?
    hardware.graphics.enable32Bit = mkIf (pkgs.system == "x86_64-linux") true;

    programs.hyprland.enable = true;

    environment.systemPackages = with pkgs; [
        hyprpaper
    ];
  };
}
