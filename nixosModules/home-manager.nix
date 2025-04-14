{ inputs, config, ...}: let
  username = config.modules.system.username;
in  {

  imports = [
    inputs.home-manager.nixosModules.home-manager
  ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;

    extraSpecialArgs = { inherit inputs; };

    users = {
      ${username} = {...}: {
        imports = [
          # some kind of path to config
          inputs.self.outputs.homeManagerModules.default
        ];
        home = {
          homeDirectory = "/home/${username}";
          stateVersion = config.modules.system.stateVersion;
        };
      };
    };
  };
}
