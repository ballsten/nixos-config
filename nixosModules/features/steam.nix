{ pkgs, ... }:
{
  programs.steam = {
    enable = true;
  };

  # TODO: move to home manager
  environment.systemPackages = [
    pkgs.rusty-path-of-building
  ];
}
