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
      # TODO: making a gaming bundle
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
    features.discord.enable = false;
  };
}
