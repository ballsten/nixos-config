{ lib, ... }:
let
  inherit (lib) mkDefault;
in
{
  myHomeManager.features.hyprland.enable = mkDefault true;
  myHomeManager.features.hypridle.enable = mkDefault true;
  myHomeManager.features.hyprsunset.enable = mkDefault true;
  myHomeManager.features.hyprlock.enable = mkDefault true;
  myHomeManager.features.hyprpaper.enable = mkDefault true;
  myHomeManager.features.waybar.enable = mkDefault true;
  myHomeManager.features.rofi.enable = mkDefault true;
  myHomeManager.features.catppuccin.enable = mkDefault true;
}
