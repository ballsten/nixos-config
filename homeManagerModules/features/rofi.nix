#
# Enable rofi for a run menu
#
{ ... }:
{
  programs.rofi = {
    enable = true;
  };

  catppuccin.rofi.enable = true;
}
