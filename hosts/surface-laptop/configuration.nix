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
  imports = [ 
    nixos-hardware.nixosModules.microsoft-surface-pro-intel
  ];

  modules = {
    system = {
      username = "ballsten";
      hashedPassword = "$y$j9T$pzQ45Xjuzy6kVT2wLfpK41$a6CozSBdXG.qJeFfn9TZUB0lIFCDi3XMJtxbLFXb3M8";
      hostName = "surface-laptop";
    };
    desktop = {
      enabled = true;
    };
  };
}
