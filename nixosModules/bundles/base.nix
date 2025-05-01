##
# Base bundle that all systems should get
#
# TODO: this should probably be split out a bit more to differentiate between servers and desktops (and wsl)
{ lib, ... }:
{
  myNixOS.features.system.enable = lib.mkDefault true;
  myNixOS.features.home-manager.enable = lib.mkDefault true;
  myNixOS.features.plymouth.enable = lib.mkDefault true;
  myNixOS.features.wgnord.enable = lib.mkDefault false;
}
