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

  outputs =
    { self, nixpkgs, ... }:
    let
      inherit (nixpkgs.lib) nixosSystem genAttrs replaceStrings;
      inherit (nixpkgs.lib.filesystem) listFilesRecursive;

      nameOf = path: replaceStrings [ ".nix" ] [ "" ] (baseNameOf (toString path));
    in
    {
      homeModules = genAttrs (map nameOf (listFilesRecursive ./homeManagerModules)) (name: import ./homeManagerModules/${name}.nix);

      nixosConfigurations = {
        surface-laptop = nixosSystem {
          system = "x86_64-linux";
          specialArgs.nix-config = self;
          modules = listFilesRecursive ./hosts/surface-laptop;
        };

        wsl = nixosSystem {
          system = "x86_64-linux";
          specialArgs.nix-config = self;
          modules = [
            ./hosts/wsl/configuration.nix
            ./nixosModules
          ];
        };
      };
    };
}
