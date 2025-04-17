###############################################################################
#
#  Surface laptop system configuration
#
#  Majority of configuration should be parametised and handled by the 
#  system module.
#
###############################################################################
{ config, ... }:
{
  imports = [ 
    ./hardware-configuration.nix
  ];
  
  nixpkgs.config.allowUnfree = true;
  hardware.graphics.enable = true;
  services.xserver.videoDrivers = ["nvidia"];
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;
    powerManagement.finegrained = false;
    open = true;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.latest;
  };
  
  myNixOS= {
    bundles = {
      base.enable = true;
      desktop.enable = true;
    };

    features = {
      system = {
        username = "ballsten";
        hashedPassword = "$y$j9T$pzQ45Xjuzy6kVT2wLfpK41$a6CozSBdXG.qJeFfn9TZUB0lIFCDi3XMJtxbLFXb3M8";
        hostName = "tiki-rig";
      };

      home-manager = {
        userConfig = ./home.nix;
      };
    };
  };

}
