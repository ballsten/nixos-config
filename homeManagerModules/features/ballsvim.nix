##
# Ballsvim configuration
# expect inputs to be provided by the flake
##
{
  inputs,
  pkgs,
  ...
}:
{
  home.packages = [
    inputs.ballsvim.packages.x86_64-linux.ballsvim
  ];
}
