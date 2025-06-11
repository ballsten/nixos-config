##
# Ballsvim configuration
# expect inputs to be provided by the flake
##
{
  pkgs,
  ...
}:
{
  home.packages = [
    pkgs.ballsvim
  ];
}
