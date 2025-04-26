{ lib, ... }: let
  inherit (lib) mkDefault;
in {
  myHomeManager.features.bash.enable = mkDefault true;
  myHomeManager.features.git.enable = mkDefault true;
  myHomeManager.features.just.enable = mkDefault true;
}
