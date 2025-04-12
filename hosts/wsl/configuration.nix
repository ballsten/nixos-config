{ nix-config, pkgs, ... }:

let
  inherit (builtins) attrValues;
  nixos-wsl = nix-config.inputs.nixos-wsl;
in
{
  imports = attrValues nix-config.nixosModules
    # add in WSL module
    # TODO: should this be based on configuration?????
    ++ [ nixos-wsl.nixosModules.wsl ];
  # nixpkgs.overlays = attrValues nix-config.overlays;
  home-manager.sharedModules = attrValues nix-config.homeModules;
  # environment.systemPackages = attrValues nix-config.packages.${pkgs.system};

  modules = {
    system = {
      username = "ballsten";
      hashedPassword = "$y$j9T$pzQ45Xjuzy6kVT2wLfpK41$a6CozSBdXG.qJeFfn9TZUB0lIFCDi3XMJtxbLFXb3M8";
      hostName = "wsl";
      wsl = true;
    };
    desktop = {
      enabled = false;
    };
  };
}
