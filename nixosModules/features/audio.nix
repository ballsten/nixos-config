##
# Audio module
##
{ pkgs, ... }:
{
  # setup pipewire
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true; # if not already enabled
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # enable the player control console commands
  services.playerctld.enable = true;
}
