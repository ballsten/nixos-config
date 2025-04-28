{
  inputs,
  outputs,
  pkgs,
  lib,
  config,
  ...
}:
{
  # home configuration
  myHomeManager = {
    bundles = {
      base.enable = true;
      desktop.enable = true;
    };
  };
}
