{ lib, ... }:
let
  inherit (lib) mkDefault;
in
{
  myHomeManager.bundles.hyprland.enable = mkDefault true;
  myHomeManager.features.wezterm.enable = mkDefault true;
  myHomeManager.features.obsidian.enable = mkDefault true;
  myHomeManager.features.gimp.enable = mkDefault true;
  myHomeManager.features.discord.enable = mkDefault true;
}
