##
# Install AppImage and GearLever
##
{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    appimage-run
    gearlever
  ];
}
