#
# install the discord package
# TODO: is there an option to declare some of the config?
#

{ pkgs, ... }:
{
  home.packages = [
    pkgs.discord
  ];
}
