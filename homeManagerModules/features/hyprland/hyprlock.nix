##
# Hyprlock to display the lock screen
##
{ pkgs, catppuccin-theme, ... }:
let
  loginpaper = pkgs.fetchurl {
    url = "http://files.theaker.name/wallpaper/spaceship-cliff-face.jpg";
    hash = "sha256-cfe76pEQ/6FL9tX4qK0hD7vPfxJPseXOe4y7g/eEKtM=";
  };
  avatar = pkgs.fetchurl {
    url = "http://files.theaker.name/images/ballsten-avatar-240x240.jpg";
    hash = "sha256-weOqsOTX+vKzZ5bK3M7TexKPOiELlHX0D1t/MoF9mYM=";
  };
  hyprlandThemeConf = (builtins.toString catppuccin-theme) + "/hyprland/mocha.conf";
in
{
  programs.hyprlock = {
    enable = true;
    settings = {
      source = hyprlandThemeConf;

      "$accent" = "$green";
      "$accentAlpha" = "$greenAlpha";
      "$font" = "FiraCode Nerd Font";

      # GENERAL
      general = {
        hide_cursor = true;
      };

      # BACKGROUND
      background = {
        # monitor = nil;
        path = builtins.toString loginpaper;
        blur_passes = 0;
        color = "$base";
      };

      label = [
        # LAYOUT
        # {
        #   # monitor =
        #   text = "Layout: $LAYOUT";
        #   color = "$text";
        #   font_size = 25;
        #   font_family = "$font";
        #   position = [
        #     30
        #     (0 - 30)
        #   ];
        #   halign = "left";
        #   valign = "top";
        # }

        # TIME
        {
          # monitor =
          text = "$TIME";
          color = "$text";
          font_size = 90;
          font_family = "$font";
          position = "-30, 0";
          halign = "right";
          valign = "top";
        }

        # DATE
        {
          # monitor =
          text = "cmd[update:43200000] date +\"%A, %d %B %Y\"";
          color = "$text";
          font_size = 25;
          font_family = "$font";
          position = "-30, -150";
          halign = "right";
          valign = "top";
        }
      ];

      # USER AVATAR
      image = {
        # monitor =
        path = builtins.toString avatar;
        size = 100;
        border_color = "$accent";
        position = "0, -19%";
        halign = "center";
        valign = "center";
      };

      # INPUT FIELD
      input-field = {
        # monitor =
        size = "300, 60";
        outline_thickness = 4;
        dots_size = 0.2;
        dots_spacing = 0.2;
        dots_center = true;
        outer_color = "$accent";
        inner_color = "$surface0";
        font_color = "$text";
        fade_on_empty = false;
        placeholder_text = "<span foreground=\"##$textAlpha\"><i>󰌾 Logged in as </i><span foreground=\"##$accentAlpha\">$USER</span></span>";
        hide_input = false;
        check_color = "$accent";
        fail_color = "$red";
        fail_text = "<i>$FAIL <b>($ATTEMPTS)</b></i>";
        capslock_color = "$yellow";
        position = "0, -25%";
        halign = "center";
        valign = "center";
      };
    };
  };

}
