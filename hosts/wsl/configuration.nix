{ nix-config, pkgs, ... }:

let
  inherit (builtins) attrValues;
  nixos-wsl = nix-config.inputs.nixos-wsl;
in
{
    # TODO: should this be based on configuration?????
  imports = [ nixos-wsl.nixosModules.wsl ];
  home-manager.sharedModules = attrValues nix-config.homeModules;

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
