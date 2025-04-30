{
  inputs,
  outputs,
  pkgs,
  lib,
  config,
  ...
}:
{
  imports = [
    # outputs.homeManagerModules.default
  ];
  # home configuration
  myHomeManager = {
    bundles.base.enable = true;
    features.fish.enable = true;
  };
}
