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
    };
    features.hyprland.suspendEnable = true;
  };
}
