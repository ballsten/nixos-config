##
# Wayle configuration
##
{ config, ... }:
{
  # then you can use it as a normal program
  services.wayle = {
    enable = true;

    # tip: you can automatically translate your TOML config to Nix by running
    # nix-instantiate --eval --expr 'builtins.fromTOML (builtins.readFile ./config.toml)' | nixfmt
    settings = {
      bar = {
        layout = [
          {
            center = [ "cava" ];
            left = [
              "notifications"
              "systray"
              "hyprland-workspaces"
              "window-title"
            ];
            monitor = "*";
            right = [
              "media"
              "weather"
              "volume"
              "clock"
            ];
            show = true;
          }
        ];
        location = "bottom";
      };
      modules = {
        clock = {
          dropdown-show-seconds = false;
          format = "%H:%M";
        };
        hyprland-workspaces = {
          label-use-name = true;
        };
        volume = {
          border-color = "blue";
          icon-bg-color = "blue";
          label-color = "blue";
        };
        weather = {
          location = "Newcastle";
        };
      };
      wallpaper = {
        engine-enabled = false;
      };
    };
  };
}
