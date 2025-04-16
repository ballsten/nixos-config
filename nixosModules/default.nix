###############################################################################
#
# nixosModules is for system wide configuration
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
  config,
  lib,
  helperLib,
  ...
}: let
  cfg = config.myNixOS;

  # Taking all modules in ./features and adding enables to them
  features =
    helperLib.extendModules
    (name: {
      extraOptions = {
        myNixOS.features.${name}.enable = lib.mkEnableOption "enable my ${name} configuration";
      };

      configExtension = config: (lib.mkIf cfg.features.${name}.enable config);
    })
    (helperLib.filesIn ./features);

  # Taking all module bundles in ./bundles and adding bundle.enables to them
  bundles =
    helperLib.extendModules
    (name: {
      extraOptions = {
        myNixOS.bundles.${name}.enable = lib.mkEnableOption "enable ${name} module bundle";
      };

      configExtension = config: (lib.mkIf cfg.bundles.${name}.enable config);
    })
    (helperLib.filesIn ./bundles);

  # Taking all module services in ./services and adding services.enables to them
  # services =
  #   helperLib.extendModules
  #   (name: {
  #     extraOptions = {
  #       myNixOS.services.${name}.enable = lib.mkEnableOption "enable ${name} service";
  #     };
  #
  #     configExtension = config: (lib.mkIf cfg.services.${name}.enable config);
  #   })
  #   (helperLib.filesIn ./services);
in {
  imports = []
    ++ features
    ++ bundles;
    # ++ services
}
