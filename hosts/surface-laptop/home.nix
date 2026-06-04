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
    features.discord.enable = false;
  };
}
