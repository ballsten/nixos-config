{ nix-config, pkgs, ... }:

let
  inherit (builtins) attrValues;
  nixos-hardware = nix-config.inputs.nixos-hardware;
in
{
  imports = attrValues nix-config.nixosModules 
    # add in linux-surface kernel
    ++ [ nixos-hardware.nixosModules.microsoft-surface-pro-intel ];
  # nixpkgs.overlays = attrValues nix-config.overlays;
  home-manager.sharedModules = attrValues nix-config.homeModules;
  # environment.systemPackages = attrValues nix-config.packages.${pkgs.system};

  modules = {
    system = {
      username = "ballsten";
      hashedPassword = "$y$j9T$pzQ45Xjuzy6kVT2wLfpK41$a6CozSBdXG.qJeFfn9TZUB0lIFCDi3XMJtxbLFXb3M8";
      hostName = "surface-laptop";
    };
  };
}
