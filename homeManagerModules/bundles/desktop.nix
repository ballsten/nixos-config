{ lib, ... }:
let
  inherit (lib) mkDefault;
in
{
  myHomeManager.features.hyprland.enable = mkDefault true;
  myHomeManager.features.wezterm.enable = mkDefault true;
  myHomeManager.features.obsidian.enable = mkDefault true;
  myHomeManager.features.gimp.enable = mkDefault true;
}
