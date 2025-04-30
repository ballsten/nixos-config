###############################################################################
#
#  WSL system configuration
#
#  Majority of configuration should be parametised and handled by the
#  system module.
#
###############################################################################
{
  inputs,
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (inputs) nixos-wsl;
  inherit (config.myNixOS.features.system) username;
in
{
  # WSL specific imports
  imports = [
    nixos-wsl.nixosModules.wsl
  ];

  wsl = {
    enable = true;
    defaultUser = username;
  };

  # Disable the boot loader for WSL
  boot.loader.systemd-boot.enable = lib.mkForce false;

  # set platform for wsl
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  # TODO: this is temporary
  programs.fish.enable = true;

  # system configuration
  myNixOS = {
    bundles = {
      base.enable = true;
      desktop.enable = false;
    };

    features = {
      system = {
        username = "ballsten";
        hashedPassword = "$y$j9T$pzQ45Xjuzy6kVT2wLfpK41$a6CozSBdXG.qJeFfn9TZUB0lIFCDi3XMJtxbLFXb3M8";
        hostName = "wsl";
        shell = pkgs.fish;
      };
      home-manager = {
        userConfig = ./home.nix;
      };
    };

  };
}
