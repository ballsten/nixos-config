{
  lib,
  config,
  inputs,
  outputs,
  helperLib,
  ...
}: let
  cfg = config.myNixOS;
in {
  imports = [
    inputs.home-manager.nixosModules.home-manager
  ];

  options.myNixOS.features.home-manager = {
    userConfig = lib.mkOption {
      type = lib.types.path;
      description = ''
        home-manager config path
      '';
    };
  };

  config = {

    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;

      extraSpecialArgs = {
        inherit inputs;
        inherit helperLib;
        outputs = inputs.self.outputs;
      };
      users = {
        ${cfg.features.system.username} = {...}: {
          imports = [
            (import cfg.features.home-manager.userConfig)
            outputs.homeManagerModules.default
          ];

          home = {
            inherit (cfg.features.system) stateVersion;
          };
        };
      };
    };
  };
}
