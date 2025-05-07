{
  lib,
  osConfig,
  pkgs,
  ...
}:
let
  cfg = osConfig.myNixOS.features.system;
in
{
  ##
  # Enable the correct shell
  ##
  myHomeManager.features.bash.enable = lib.mkDefault (if cfg.shell == pkgs.bash then true else false);
  myHomeManager.features.fish.enable = lib.mkDefault (if cfg.shell == pkgs.fish then true else false);
  myHomeManager.features.fonts.enable = lib.mkDefault true;
  myHomeManager.features.git.enable = lib.mkDefault true;
  myHomeManager.features.just.enable = lib.mkDefault true;
  myHomeManager.features.ballsvim.enable = lib.mkDefault true;
  myHomeManager.features.direnv.enable = lib.mkDefault true;
  myHomeManager.features.awscli.enable = lib.mkDefault true;
}
