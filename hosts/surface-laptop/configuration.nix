###############################################################################
#
#  Surface laptop system configuration
#
#  Majority of configuration should be parametised and handled by the 
#  system module.
#
###############################################################################
{ inputs, ... }:
let
  inherit (inputs) nixos-hardware;
in
{
  # surface-laptop specific import, hardware and linux-surface kernel
  imports = [ 
    ./hardware-configuration.nix
    nixos-hardware.nixosModules.microsoft-surface-pro-intel
  ];
  
  # enable bluetooth
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  myNixOS= {
    bundles = {
      base.enable = true;
      desktop.enable = true;
    };

    features.system = {
      username = "ballsten";
      hashedPassword = "$y$j9T$pzQ45Xjuzy6kVT2wLfpK41$a6CozSBdXG.qJeFfn9TZUB0lIFCDi3XMJtxbLFXb3M8";
      hostName = "surface-laptop";
    };
  };
}
