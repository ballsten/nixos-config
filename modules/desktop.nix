
{
  pkgs,
  config,
  lib,
  ...
}:

let
  inherit (config.modules.system) username;

  inherit (lib)
    mkEnableOption
    mkDefault
    mkIf
    mkMerge
    ;

  cfg = config.modules.desktop;
in
{
  options.modules.desktop = {
    enable = mkDefault false;
  };

  config = {
    # TODO: what is this?
    hardware.graphics.enable32Bit = mkIf (pkgs.system == "x86_64-linux") true;

    programs.hyprland.enable = true;
  };
}
