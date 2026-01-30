# greetd feature to enable a login screen using regreet
{
  pkgs,
  lib,
  config,
  ...
}:
let
  wallpaper = pkgs.fetchurl {
    url = "http://files.theaker.name/wallpaper/ice-planet-spaceship.jpg";
    hash = "sha256-KJH14CWjH/Xe0xV1keQFn/lB/vgqp0ZDaK3xpzDGBg8=";
  };
  hyprlandConf = pkgs.writeText "hyprland.conf" ''
    exec-once = ${lib.getExe config.programs.regreet.package}; hyprctl dispatch exit
    debug {
      disable_logs = false
    }
    misc {
        disable_hyprland_logo = true
        disable_splash_rendering = true
        disable_hyprland_guiutils_check = true
    }
  '';
in
{
  environment.systemPackages = with pkgs; [
    #nordic
    (catppuccin-gtk.override {
      variant = "mocha";
      accents = [ "green" ];
    })
  ];
  programs.regreet = {
    enable = true;
    settings = {
      background = {
        path = builtins.toString wallpaper;
        fit = "Cover";
      };
      GTK = {
        theme_name = lib.mkForce "catppuccin-mocha-green-standard";
        # theme_name = lib.mkForce "Nordic";
        # icon_theme_name = lib.mkForce "Nordic";
        # cursor_theme_name = lib.mkForce "Nordic";
        application_prefer_dark_theme = lib.mkForce true;
      };
    };
  };

  services.greetd.settings.default_session.command =
    "start-hyprland -- --config ${builtins.toString hyprlandConf}";
}
