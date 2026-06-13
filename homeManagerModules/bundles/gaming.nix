{ lib, ... }:
let
  inherit (lib) mkDefault;
in
{
  myHomeManager.features.discord.enable = mkDefault true;
}
