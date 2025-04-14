{
  nix-config,
  pkgs,
  lib,
  config,
  ...
}:

{
  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
  ];
}
