##
# hypridle for locking and power management
##
{ config, ... }:
let
  cfg = config.myHomeManager.features.hyprland;
in
{
  services.hypridle = {
    enable = true;
    settings = {
      general = {
        lock_cmd = "pidof hyprlock || hyprlock";
        before_sleep_cmd = "loginctl lock-session";
        after_sleep_cmd = "hyprctl dispatch dpms on";
      };
      listener =
        [
          # TODO: brightnessctl only works on the laptop
          {
            timeout = 150;
            on-timeout = "brightnessctl -s set 10";
            on-resume = "brightnessctl -r";
          }
          {
            timeout = 300;
            on-timeout = "loginctl lock-session";
          }
          {
            timeout = 330;
            on-timeout = "hyprctl dispatch dpms off";
            on-resume = "hyprctl dispatch dpms on && brightnessctl -r";
          }
        ]
        ++ (
          if cfg.suspendEnable then
            [
              {
                timeout = 1800;
                on-timeout = "systemctl suspend";
              }
            ]
          else
            [ ]
        );
    };
  };
}
