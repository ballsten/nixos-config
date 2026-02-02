##
# Ballsvim configuration
# expect inputs to be provided by the flake
##
{
  inputs,
  ...
}:
{
  home.packages = [
    inputs.ballsvim.packages.x86_64-linux.default
  ];
}
