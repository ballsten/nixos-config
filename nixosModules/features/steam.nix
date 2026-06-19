{ pkgs, ... }:
{
  programs = {
    steam = {
      enable = true;
      extraCompatPackages = with pkgs; [
        proton-ge-bin
      ];
    };
    gamemode.enable = true;
  };

  # TODO: move to home manager
  environment.systemPackages = [
    pkgs.rusty-path-of-building
  ];
}
