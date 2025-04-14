###############################################################################
#
#  My NixOS configuration
#
#  Designed to be modular to support multiple systems.
#
#  Currently supported: (see hosts/<system>/configuration.nix)
#  - surface-laptop
#  - wsl
#  - VM (hyperV)
#
#  Uses home-manager to user configuration (see hosts/<system>/home.nix)
#
#
###############################################################################

{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL/main";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ballsvim = {
      url = "github:ballsten/nvim-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, ... }@inputs: {
    nixosConfigurations = {
      wsl = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          ./hosts/wsl/configuration.nix
          ./nixosModules
        ];
      };
    };
    
    homeManagerModules.default = ./homeManagerModules;
  };
}
