
{ lib, ... }:
let
  inherit (lib) mkDefault;
in
{
  myNixOS.features.steam.enable = mkDefault true;
}
