##
# Hyprlock to display the lock screen
##
{
  pkgs,
  ...
}:
let
  avatar = pkgs.fetchurl {
    url = "http://files.theaker.name/images/ballsten-avatar-240x240.jpg";
    hash = "sha256-weOqsOTX+vKzZ5bK3M7TexKPOiELlHX0D1t/MoF9mYM=";
  };
in
{
  programs.hyprlock = {
    enable = true;
    settings = {

      # GENERAL
      general = {
        hide_cursor = true;
      };

      # BACKGROUND
      background = {
        # monitor = nil;
        blur_passes = 0;
      };

      label = [
        # TIME
        {
          # monitor =
          text = "$TIME";
          font_size = 90;
          position = "-30, 0";
          halign = "right";
          valign = "top";
        }

        # DATE
        {
          # monitor =
          text = "cmd[update:43200000] date +\"%A, %d %B %Y\"";
          font_size = 25;
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
        # border_color = "$accent";
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
        fade_on_empty = false;
        placeholder_text = "<i>󰌾 Logged in as </i>$USER";
        hide_input = false;
        fail_text = "<i>$FAIL <b>($ATTEMPTS)</b></i>";
        # capslock_color = "$yellow";
        position = "0, -25%";
        halign = "center";
        valign = "center";
      };
    };
  };

}
