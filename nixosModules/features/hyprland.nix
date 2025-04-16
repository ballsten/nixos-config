# TODO: validate what parts can be moved into user space
{ pkgs, lib, ... }:
{
  # TODO: what is this?
  hardware.graphics.enable32Bit = lib.mkIf (pkgs.system == "x86_64-linux") true;

  programs.hyprland.enable = true;

  environment.systemPackages = with pkgs; [
      hyprpaper
  ];
}
