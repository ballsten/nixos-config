# greetd feature to enable a login screen using regreet
{ pkgs, lib, config, ... }: let
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
        disable_hyprland_qtutils_check = true
    }
  '';
in
{
  programs.regreet = {
    enable = true;
    settings = {
      background = {
        path = builtins.toString wallpaper;
        fit = "Cover";
      };
    };
  };
  
  services.greetd.settings.default_session.command = "Hyprland --config ${builtins.toString hyprlandConf}";
}
