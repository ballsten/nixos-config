{
  pkgs,
  lib,
  config,
  ...
}:
let
  wallpaper = pkgs.fetchurl {
    url = "http://files.theaker.name/wallpaper/futuristic-spaceship-pilot.jpg";
    hash = "sha256-fM8HGoicFjSpUOVM2RIOGP7QQ+BTQw0Yotp5ObxBM9Q=";
  };
  loginpaper = pkgs.fetchurl {
    url = "http://files.theaker.name/wallpaper/spaceship-cliff-face.jpg";
    hash = "sha256-cfe76pEQ/6FL9tX4qK0hD7vPfxJPseXOe4y7g/eEKtM=";
  };
  cfg = config.myHomeManager.features.hyprland;
in
{
  options = {
    myHomeManager.features.hyprland = {
      terminal = lib.mkOption {
        type = lib.types.str;
        default = "wezterm";
        description = "the default terminal program for hyprland";
      };
    };
  };

  home.packages = with pkgs; [
    hyprpicker
  ];

  ##
  # Themeing
  ##
  home.file = {
    hyprlandTheme = {
      target = ".config/hypr/mocha.conf";
      text = ''
        $rosewater = rgb(f5e0dc)
        $rosewaterAlpha = f5e0dc

        $flamingo = rgb(f2cdcd)
        $flamingoAlpha = f2cdcd

        $pink = rgb(f5c2e7)
        $pinkAlpha = f5c2e7

        $mauve = rgb(cba6f7)
        $mauveAlpha = cba6f7

        $red = rgb(f38ba8)
        $redAlpha = f38ba8

        $maroon = rgb(eba0ac)
        $maroonAlpha = eba0ac

        $peach = rgb(fab387)
        $peachAlpha = fab387

        $yellow = rgb(f9e2af)
        $yellowAlpha = f9e2af

        $green = rgb(a6e3a1)
        $greenAlpha = a6e3a1

        $teal = rgb(94e2d5)
        $tealAlpha = 94e2d5

        $sky = rgb(89dceb)
        $skyAlpha = 89dceb

        $sapphire = rgb(74c7ec)
        $sapphireAlpha = 74c7ec

        $blue = rgb(89b4fa)
        $blueAlpha = 89b4fa

        $lavender = rgb(b4befe)
        $lavenderAlpha = b4befe

        $text = rgb(cdd6f4)
        $textAlpha = cdd6f4

        $subtext1 = rgb(bac2de)
        $subtext1Alpha = bac2de

        $subtext0 = rgb(a6adc8)
        $subtext0Alpha = a6adc8

        $overlay2 = rgb(9399b2)
        $overlay2Alpha = 9399b2

        $overlay1 = rgb(7f849c)
        $overlay1Alpha = 7f849c

        $overlay0 = rgb(6c7086)
        $overlay0Alpha = 6c7086

        $surface2 = rgb(585b70)
        $surface2Alpha = 585b70

        $surface1 = rgb(45475a)
        $surface1Alpha = 45475a

        $surface0 = rgb(313244)
        $surface0Alpha = 313244

        $base = rgb(1e1e2e)
        $baseAlpha = 1e1e2e

        $mantle = rgb(181825)
        $mantleAlpha = 181825

        $crust = rgb(11111b)
        $crustAlpha = 11111b
      '';
    };
  };

  ##
  # Main applications
  ##

  # TODO: modularize these (terminal already done) but enable programs
  programs.firefox.enable = true;

  ##
  # Hyprlock configuration
  ##
  programs.hyprlock = {
    enable = true;
    settings = {
      source = "$HOME/.config/hypr/mocha.conf";

      "$accent" = "$mauve";
      "$accentAlpha" = "$mauveAlpha";
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
      # image = {
      #   monitor =
      #   path = $HOME/.face
      #   size = 100
      #   border_color = $accent
      #   position = 0, 75
      #   halign = center
      #   valign = center
      # }

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
        position = "0, -47";
        halign = "center";
        valign = "center";
      };
    };
  };

  ##
  # Waybar configuration
  ##
  programs.waybar = {
    enable = true;
    settings = {
      mainbar = {
        layer = "top";
        position = "bottom";
        modules-left = [ "hyprland/workspaces" ];
        modules-right = [
          "battery"
          "clock"
        ];
        battery = {
          format = "{capacity}% {icon}";
          format-icons = [
            ""
            ""
            ""
            ""
            ""
          ];
        };
        clock = {
          format-alt = "{:%a, %d. %b  %H:%M}";
        };
      };
    };
    style = ''
      * {
        border: none;
        border-radius: 0;
        font-family: FiraCode Nerd Font;
        font-size: 18px;
        min-height: 0;
      }

      window#waybar {
        background: #000000;
        color: #e5e9f0;
      }

      #workspaces button {
        padding: 0 5px;
        background: transparent;
        color: #ffffff;
        border-bottom: 3px solid transparent;
      }

      #workspaces button.focused {
        background: #4c566a;
        border-bottom: 3px solid #e5e9f0;
      }

      #workspaces button.urgent {
        background-color: #bf616a;
      }

      #mode {
        background: #64727D;
        border-bottom: 3px solid #ffffff;
      }

      #clock #battery #mode {
        padding: 0 10px;
        margin: 0 10px;
      }

      #battery {
        margin-right: 30px;
      }
    '';
  };

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

  wayland.windowManager.hyprland = {
    enable = true;

    settings = {

      ################
      ### MONITORS ###
      ################

      # See https://wiki.hyprland.org/Configuring/Monitors/
      monitor = lib.mkDefault ",preferred,auto,auto";

      ###################
      ### MY PROGRAMS ###
      ###################

      # See https://wiki.hyprland.org/Configuring/Keywords/

      # Set programs that you use
      "$terminal" = cfg.terminal;
      "$browser" = "firefox";
      "$lockscreen" = "hyprlock";

      # TODO: probably use these at some point
      # $fileManager = dolphin
      # $menu = wofi --show drun

      #################
      ### AUTOSTART ###
      #################

      # Autostart necessary processes (like notifications daemons, status bars, etc.)
      # Or execute your favorite apps at launch like this:

      exec-once = [
        "hyprpaper"
        "waybar"
      ];
      # exec-once = nm-applet &
      # exec-once = waybar & hyprpaper & firefox

      #############################
      ### ENVIRONMENT VARIABLES ###
      #############################

      # See https://wiki.hyprland.org/Configuring/Environment-variables/

      env = [
        "XCURSOR_SIZE,24"
        "HYPRCURSOR_SIZE,24"
      ];

      #####################
      ### LOOK AND FEEL ###
      #####################

      # Refer to https://wiki.hyprland.org/Configuring/Variables/

      # https://wiki.hyprland.org/Configuring/Variables/#general
      general = {
        gaps_in = 5;
        gaps_out = 20;

        border_size = 2;

        # https://wiki.hyprland.org/Configuring/Variables/#variable-types for info about colors
        "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
        "col.inactive_border" = "rgba(595959aa)";

        # Set to true enable resizing windows by clicking and dragging on borders and gaps
        resize_on_border = false;

        # Please see https://wiki.hyprland.org/Configuring/Tearing/ before you turn this on
        allow_tearing = false;

        layout = "dwindle";
      };

      # https://wiki.hyprland.org/Configuring/Variables/#decoration
      decoration = {
        rounding = 10;

        # Change transparency of focused and unfocused windows
        active_opacity = 1.0;
        inactive_opacity = 1.0;

        shadow = {
          enabled = true;
          range = 4;
          render_power = 3;
          color = "rgba(1a1a1aee)";
        };

        # https://wiki.hyprland.org/Configuring/Variables/#blur
        blur = {
          enabled = true;
          size = 3;
          passes = 1;

          vibrancy = 0.1696;
        };
      };

      # https://wiki.hyprland.org/Configuring/Variables/#animations
      animations = {
        enabled = "yes, please :)";

        # Default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more

        bezier = [
          "easeOutQuint,0.23,1,0.32,1"
          "easeInOutCubic,0.65,0.05,0.36,1"
          "linear,0,0,1,1"
          "almostLinear,0.5,0.5,0.75,1.0"
          "quick,0.15,0,0.1,1"
        ];

        animation = [
          "global, 1, 10, default"
          "border, 1, 5.39, easeOutQuint"
          "windows, 1, 4.79, easeOutQuint"
          "windowsIn, 1, 4.1, easeOutQuint, popin 87%"
          "windowsOut, 1, 1.49, linear, popin 87%"
          "fadeIn, 1, 1.73, almostLinear"
          "fadeOut, 1, 1.46, almostLinear"
          "fade, 1, 3.03, quick"
          "layers, 1, 3.81, easeOutQuint"
          "layersIn, 1, 4, easeOutQuint, fade"
          "layersOut, 1, 1.5, linear, fade"
          "fadeLayersIn, 1, 1.79, almostLinear"
          "fadeLayersOut, 1, 1.39, almostLinear"
          "workspaces, 1, 1.94, almostLinear, fade"
          "workspacesIn, 1, 1.21, almostLinear, fade"
          "workspacesOut, 1, 1.94, almostLinear, fade"
        ];
      };

      # Ref https://wiki.hyprland.org/Configuring/Workspace-Rules/
      # "Smart gaps" / "No gaps when only"
      # uncomment all if you wish to use that.
      # workspace = w[tv1], gapsout:0, gapsin:0
      # workspace = f[1], gapsout:0, gapsin:0
      # windowrulev2 = bordersize 0, floating:0, onworkspace:w[tv1]
      # windowrulev2 = rounding 0, floating:0, onworkspace:w[tv1]
      # windowrulev2 = bordersize 0, floating:0, onworkspace:f[1]
      # windowrulev2 = rounding 0, floating:0, onworkspace:f[1]

      # See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
      dwindle = {
        pseudotile = true; # Master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
        preserve_split = true; # You probably want this
      };

      # See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
      master = {
        new_status = "master";
      };

      # https://wiki.hyprland.org/Configuring/Variables/#misc
      misc = {
        force_default_wallpaper = 0; # Set to 0 or 1 to disable the anime mascot wallpapers
        disable_hyprland_logo = true; # If true disables the random hyprland logo / anime girl background. :(
      };

      #############
      ### INPUT ###
      #############

      # https://wiki.hyprland.org/Configuring/Variables/#input
      input = {
        kb_layout = "us";
        kb_variant = "";
        kb_model = "";
        kb_options = "";
        kb_rules = "";

        follow_mouse = 1;

        sensitivity = 0; # -1.0 - 1.0, 0 means no modification.

        touchpad = {
          natural_scroll = true;
        };
      };

      # https://wiki.hyprland.org/Configuring/Variables/#gestures
      gestures = {
        workspace_swipe = false;
      };

      # Example per-device config
      # See https://wiki.hyprland.org/Configuring/Keywords/#per-device-input-configs for more
      device = {
        name = "epic-mouse-v1";
        sensitivity = -0.5;
      };

      ###################
      ### KEYBINDINGS ###
      ###################

      # See https://wiki.hyprland.org/Configuring/Keywords/
      "$mainMod" = "SUPER"; # Sets "Windows" key as main modifier

      # Example binds, see https://wiki.hyprland.org/Configuring/Binds/ for more
      bind = [
        "$mainMod, Q, exec, $terminal"
        "$mainMod, F, exec, $browser"
        "$mainMod, L, exec, $lockscreen"
        "$mainMod, C, killactive,"
        "$mainMod, M, exit,"
        "$mainMod, E, exec, $fileManager"
        "$mainMod, V, togglefloating,"
        "$mainMod, R, exec, $menu"
        "$mainMod, P, pseudo," # dwindle
        "$mainMod, J, togglesplit," # dwindle

        # Move focus with mainMod + arrow keys
        "$mainMod, left, movefocus, l"
        "$mainMod, right, movefocus, r"
        "$mainMod, up, movefocus, u"
        "$mainMod, down, movefocus, d"

        # Switch workspaces with mainMod + [0-9]
        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"
        "$mainMod, 5, workspace, 5"
        "$mainMod, 6, workspace, 6"
        "$mainMod, 7, workspace, 7"
        "$mainMod, 8, workspace, 8"
        "$mainMod, 9, workspace, 9"
        "$mainMod, 0, workspace, 10"

        # Move active window to a workspace with mainMod + SHIFT + [0-9]
        "$mainMod SHIFT, 1, movetoworkspace, 1"
        "$mainMod SHIFT, 2, movetoworkspace, 2"
        "$mainMod SHIFT, 3, movetoworkspace, 3"
        "$mainMod SHIFT, 4, movetoworkspace, 4"
        "$mainMod SHIFT, 5, movetoworkspace, 5"
        "$mainMod SHIFT, 6, movetoworkspace, 6"
        "$mainMod SHIFT, 7, movetoworkspace, 7"
        "$mainMod SHIFT, 8, movetoworkspace, 8"
        "$mainMod SHIFT, 9, movetoworkspace, 9"
        "$mainMod SHIFT, 0, movetoworkspace, 10"

        # Example special workspace (scratchpad)
        "$mainMod, S, togglespecialworkspace, magic"
        "$mainMod SHIFT, S, movetoworkspace, special:magic"

        # Scroll through existing workspaces with mainMod + scroll
        "$mainMod, mouse_down, workspace, e+1"
        "$mainMod, mouse_up, workspace, e-1"
      ];

      # Move/resize windows with mainMod + LMB/RMB and dragging
      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];

      # Laptop multimedia keys for volume and LCD brightness
      bindel = [
        ",XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
        ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ",XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
        ",XF86MonBrightnessUp, exec, brightnessctl s 10%+"
        ",XF86MonBrightnessDown, exec, brightnessctl s 10%-"
      ];

      # Requires playerctl
      bindl = [
        ", XF86AudioNext, exec, playerctl next"
        ", XF86AudioPause, exec, playerctl play-pause"
        ", XF86AudioPlay, exec, playerctl play-pause"
        ", XF86AudioPrev, exec, playerctl previous"
      ];

      ##############################
      ### WINDOWS AND WORKSPACES ###
      ##############################

      # See https://wiki.hyprland.org/Configuring/Window-Rules/ for more
      # See https://wiki.hyprland.org/Configuring/Workspace-Rules/ for workspace rules

      # Example windowrule v1
      # windowrule = float, ^(kitty)$

      # Example windowrule v2
      # windowrulev2 = float,class:^(kitty)$,title:^(kitty)$

      windowrulev2 = [
        # Ignore maximize requests from apps. You'll probably like this.
        "suppressevent maximize, class:.*"

        # Fix some dragging issues with XWayland
        "nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"
      ];
    };

  };
}
