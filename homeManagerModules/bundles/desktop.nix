{ lib, ... }:
let
  inherit (lib) mkDefault;
in
{
  myHomeManager.features.hyprland.enable = mkDefault true;
  myHomeManager.features.wezterm.enable = mkDefault true;
  # remove temporarily due to error
  myHomeManager.features.logseq.enable = mkDefault false;
}
