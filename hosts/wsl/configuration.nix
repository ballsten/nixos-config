###############################################################################
#
#  WSL system configuration
#
#  Majority of configuration should be parametised and handled by the 
#  system module.
#
###############################################################################
{ inputs, config, lib, ...}:
let
  inherit (inputs) nixos-wsl;
in
{
  # WSL specific imports
  imports = [
    nixos-wsl.nixosModules.wsl
  ];

  wsl = {
    enable = true;
    defaultUser = config.modules.system.username;
  };

  # Disable the boot loader for WSL
  boot.loader.systemd-boot.enable = lib.mkForce false;
  modules = {
    system = {
      username = "ballsten";
      hashedPassword = "$y$j9T$pzQ45Xjuzy6kVT2wLfpK41$a6CozSBdXG.qJeFfn9TZUB0lIFCDi3XMJtxbLFXb3M8";
      hostName = "wsl";
    };
    # desktop = {
    #   enabled = false;
    # };
  };
}
