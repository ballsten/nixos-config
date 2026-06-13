##
# Home configuration for surface laptop
##
{
  ...
}:
{
  # home configuration
  myHomeManager = {
    bundles = {
      base.enable = true;
      desktop.enable = true;
      gaming.enable = false;
    };
    features.hyprland.suspendEnable = true;
    features.hyprland.monitors = /* lua */ ''
      hl.monitor({
        output = "eDP-1",
        mode = "preferred",
        position = "auto",
        scale = "2"
      });
    '';
  };
}
