{ ... }:
{
  imports = [
    # outputs.homeManagerModules.default
  ];

  # override monitors
  wayland.windowManager.hyprland.settings.monitor = [
    "DP-2,preferred,auto,auto"
    "DP-3,preferred,auto-left,auto"
  ];

  # home configuration
  myHomeManager = {
    bundles = {
      base.enable = true;
      desktop.enable = true;
    };
  };
}
