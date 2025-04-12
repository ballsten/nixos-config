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
      inherit (nixpkgs.lib.filesystem) packagesFromDirectoryRecursive listFilesRecursive;

      forAllSystems =
        function:
        genAttrs [
          "x86_64-linux"
          "aarch64-linux"
        ] (system: function nixpkgs.legacyPackages.${system});

      nameOf = path: replaceStrings [ ".nix" ] [ "" ] (baseNameOf (toString path));
    in
    {
      # packages = forAllSystems (
      #   pkgs:
      #   packagesFromDirectoryRecursive {
      #     inherit (pkgs) callPackage;

      #     directory = ./packages;
      #   }
      # );

      nixosModules = genAttrs (map nameOf (listFilesRecursive ./nixosModules)) (
        name: import ./nixosModules/${name}.nix
      );

      homeModules = genAttrs (map nameOf (listFilesRecursive ./homeManagerModules)) (name: import ./homeManagerModules/${name}.nix);

      # overlays = genAttrs (map nameOf (listFilesRecursive ./overlays)) (
      #   name: import ./overlays/${name}.nix
      # );

      checks = forAllSystems (
        pkgs:
        genAttrs (map nameOf (listFilesRecursive ./tests)) (
          name:
          import ./tests/${name}.nix {
            inherit self pkgs;
          }
        )
      );

      nixosConfigurations = {
        surface-laptop = nixosSystem {
          system = "x86_64-linux";
          specialArgs.nix-config = self;
          modules = listFilesRecursive ./hosts/surface-laptop;
        };

        wsl = nixosSystem {
          system = "x86_64-linux";
          specialArgs.nix-config = self;
          modules = listFilesRecursive ./hosts/wsl;
        };
      };

      formatter = forAllSystems (pkgs: pkgs.nixfmt-rfc-style);
    };
}
