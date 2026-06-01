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
      general = with config.stylix.fonts; {
        font-mono = monospace;
        font-sans = sansSerif;
      };
      styling = {
        palette = with config.lib.stylix.colors.withHashtag; {
          bg = base00;
          surface = base01;
          elevated = base02;
          fg = base05;
          fg-muted = base04;
          primary = base03;
          red = base08;
          yellow = base0A;
          green = base0B;
          blue = base0D;
        };
      };
      wallpaper = {
        engine-enabled = false;
      };
    };
  };
}
