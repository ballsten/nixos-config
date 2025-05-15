##
# Hyprpaper to manage wallpaper
##
{ pkgs, ... }:
let
  wallpaper = pkgs.fetchurl {
    url = "http://files.theaker.name/wallpaper/futuristic-spaceship-pilot.jpg";
    hash = "sha256-fM8HGoicFjSpUOVM2RIOGP7QQ+BTQw0Yotp5ObxBM9Q=";
  };
in
{
  services.hyprpaper = {
    enable = true;
    settings = {
      ipc = "on";
      preload = [
        (builtins.toString wallpaper)
      ];

      wallpaper = [
        ",${builtins.toString wallpaper}"
      ];
    };
  };
}
