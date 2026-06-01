{ ... }:
{
  imports = [
    # outputs.homeManagerModules.default
  ];

  # override monitors
  # TODO: uncomment this once hyprland lua config is working
  # wayland.windowManager.hyprland.settings.monitor = [
  #   "DP-2,preferred,auto,auto"
  #   "DP-3,preferred,auto-left,auto"
  # ];

  # home configuration
  myHomeManager = {
    bundles = {
      base.enable = true;
      desktop.enable = true;
    };

    features.hyprland.monitors = /* lua */ ''
      hl.monitor({
        output = "DP-2",
        mode = "preferred",
        position = "auto",
        scale = "auto"
      });
      hl.monitor({
        output = "DP-3",
        mode = "preferred",
        position = "auto-left",
        scale = "auto"
      });
    '';
  };
}
