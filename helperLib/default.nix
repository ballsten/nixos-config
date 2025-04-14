###############################################################################
#
#  This is a set of helper functions
#
#  The main aim is to reduce the amount of boiler plate in my config
#
#  Borrowed a lot of the ideas from vimjoyer
#
###############################################################################
{inputs}: let
  helperLib = (import ./default.nix) {inherit inputs;};
  outputs = inputs.self.outputs;
in rec {
  mkSystem = config:
    inputs.nixpkgs.lib.nixosSystem {
      specialArgs = {
        inherit inputs outputs helperLib;
      };
      modules = [
        config
        outputs.nixosModules.default
      ];
    };
}
