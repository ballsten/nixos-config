{ lib, ... }: 
{
  # mutual exclusive sytem configurations
  options.modules.system.variant = lib.mkOption {
    type = lib.types.enum [ 
      "none"
      "wsl"
      "surface-laptop"
    ];
    default = "none";
    description = ''
      System variant configuration
      none: standard configuration
      wsl: Windows Subsystem for Linux
      surface-laptop: Microsoft Surface Pro Intel
    '';
  };
  
  imports = [
    ./wsl.nix
  ];
}
