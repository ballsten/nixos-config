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
  
  # enable unfree software (mainly for the nvidia drivers
  nixpkgs.config.allowUnfree = true;

  # enable nvidia
  hardware.graphics.enable = true;
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;
    powerManagement.finegrained = false;
    open = true;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.latest;
  };
  
  # setup dual boot for windows
  boot.loader.systemd-boot.windows = {
    "11-home" = {
      title = "Windows 11 Home";
      efiDeviceHandle = "HD1b";
      sortKey = "z_windows";
    };
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
