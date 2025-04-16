###############################################################################
#
# homeManagerModules is for home-manager configuration
#
# This script is just a wrapper to import all the features, modules and
# services defined in the catalogue.
#
# The wrapper adds an enable flag for each module in the appropriate namespace.
#
# features - core building blocks of a system. Limited to a main software 
#            package and appropriate default configuration.
# services - system services and appropriate default configuration
# bundles  - groups of features and services with reasonable defaults
#
###############################################################################

{
  pkgs,
  system,
  inputs,
  config,
  lib,
  helperLib,
  ...
}: let
  cfg = config.myHomeManager;

  # Taking all modules in ./features and adding feature.enable to them
  features =
    helperLib.extendModules
    (name: {
      extraOptions = {
        myHomeManager.features.${name}.enable = lib.mkEnableOption "enable my ${name} configuration";
      };

      configExtension = config: (lib.mkIf cfg.features.${name}.enable config);
    })
    (helperLib.filesIn ./features);

  # Taking all module bundles in ./bundles and adding bundle.enables to them
  bundles =
    helperLib.extendModules
    (name: {
      extraOptions = {
        myHomeManager.bundles.${name}.enable = lib.mkEnableOption "enable ${name} module bundle";
      };

      configExtension = config: (lib.mkIf cfg.bundles.${name}.enable config);
    })
    (helperLib.filesIn ./bundles);
in {
  imports =
    []
    ++ features
    ++ bundles;
}
