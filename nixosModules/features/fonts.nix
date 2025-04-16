# TODO: fonts should probably be in the userspace
{ pkgs, ... }:
{
  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
  ];
}
