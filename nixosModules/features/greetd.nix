#
# greetd feature to enable a login screen using regreet
{ pkgs, lib, ... }:
{
  programs.regreet.enable = true;
}
