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
  avatar = pkgs.fetchurl {
    url = "http://files.theaker.name/images/ballsten-avatar-240x240.jpg";
    hash = "sha256-weOqsOTX+vKzZ5bK3M7TexKPOiELlHX0D1t/MoF9mYM=";
  };
  catppuccin-theme = import ./catppuccin-theme.nix { inherit pkgs; };
  hyprlandThemeConf = (builtins.toString catppuccin-theme) + "/hyprland/mocha.conf";
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

  imports = [
    (import ./waybar.nix { inherit catppuccin-theme; })
  ];

  home.packages = with pkgs; [
    hyprpicker
    catppuccin-theme
  ];

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
  ##
  # hypridle configuration
  ##
  services.hypridle = {
    enable = true;
    settings = {
      general = {
        lock_cmd = "pidof hyprlock || hyprlock";
        before_sleep_cmd = "loginctl lock-session";
        after_sleep_cmd = "hyprctl dispatch dpms on";
      };
      listener = [
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
        {
          timeout = 1800;
          on-timeout = "systemctl suspend";
        }
      ];

    };
  };

  ##
  # wofi configuration
  ##
  programs.wofi = {
    enable = true;
    settings = {
      show = "drun";
      width = "40%";
      lines = 11;
      hide_scroll = true;
      allow_images = true;
      image_size = 25;
      prompt = "Search...";
      normal_window = false;
      matching = "fuzzy";
      insensitive = true;
      columns = 2;
    };
    # TODO: https://github.com/quantumfate/wofi
    style = ''
      @define-color	rosewater  #f5e0dc;
      @define-color	rosewater-rgb  rgb(245, 224, 220);
      @define-color	flamingo  #f2cdcd;
      @define-color	flamingo-rgb  rgb(242, 205, 205);
      @define-color	pink  #f5c2e7;
      @define-color	pink-rgb  rgb(245, 194, 231);
      @define-color	mauve  #cba6f7;
      @define-color	mauve-rgb  rgb(203, 166, 247);
      @define-color	red  #f38ba8;
      @define-color	red-rgb  rgb(243, 139, 168);
      @define-color	maroon  #eba0ac;
      @define-color	maroon-rgb  rgb(235, 160, 172);
      @define-color	peach  #fab387;
      @define-color	peach-rgb  rgb(250, 179, 135);
      @define-color	yellow  #f9e2af;
      @define-color	yellow-rgb  rgb(249, 226, 175);
      @define-color	green  #a6e3a1;
      @define-color	green-rgb  rgb(166, 227, 161);
      @define-color	teal  #94e2d5;
      @define-color	teal-rgb  rgb(148, 226, 213);
      @define-color	sky  #89dceb;
      @define-color	sky-rgb  rgb(137, 220, 235);
      @define-color	sapphire  #74c7ec;
      @define-color	sapphire-rgb  rgb(116, 199, 236);
      @define-color	blue  #89b4fa;
      @define-color	blue-rgb  rgb(137, 180, 250);
      @define-color	lavender  #b4befe;
      @define-color	lavender-rgb  rgb(180, 190, 254);
      @define-color	text  #cdd6f4;
      @define-color	text-rgb  rgb(205, 214, 244);
      @define-color	subtext1  #bac2de;
      @define-color	subtext1-rgb  rgb(186, 194, 222);
      @define-color	subtext0  #a6adc8;
      @define-color	subtext0-rgb  rgb(166, 173, 200);
      @define-color	overlay2  #9399b2;
      @define-color	overlay2-rgb  rgb(147, 153, 178);
      @define-color	overlay1  #7f849c;
      @define-color	overlay1-rgb  rgb(127, 132, 156);
      @define-color	overlay0  #6c7086;
      @define-color	overlay0-rgb  rgb(108, 112, 134);
      @define-color	surface2  #585b70;
      @define-color	surface2-rgb  rgb(88, 91, 112);
      @define-color	surface1  #45475a;
      @define-color	surface1-rgb  rgb(69, 71, 90);
      @define-color	surface0  #313244;
      @define-color	surface0-rgb  rgb(49, 50, 68);
      @define-color	base  #1e1e2e;
      @define-color	base-rgb  rgb(30, 30, 46);
      @define-color	mantle  #181825;
      @define-color	mantle-rgb  rgb(24, 24, 37);
      @define-color	crust  #11111b;
      @define-color	crust-rgb  rgb(17, 17, 27);

      * {
        font-family: 'FiraCode Nerd Font', monospace;
        font-size: 14px;
      }

      /* Window */
      window {
        margin: 0px;
        padding: 10px;
        border: 0.16em solid @lavender;
        border-radius: 0.1em;
        background-color: @base;
        animation: slideIn 0.5s ease-in-out both;
      }

      /* Slide In */
      @keyframes slideIn {
        0% {
           opacity: 0;
        }

        100% {
           opacity: 1;
        }
      }

      /* Inner Box */
      #inner-box {
        margin: 5px;
        padding: 10px;
        border: none;
        background-color: @base;
        animation: fadeIn 0.5s ease-in-out both;
      }

      /* Fade In */
      @keyframes fadeIn {
        0% {
           opacity: 0;
        }

        100% {
           opacity: 1;
        }
      }

      /* Outer Box */
      #outer-box {
        margin: 5px;
        padding: 10px;
        border: none;
        background-color: @base;
      }

      /* Scroll */
      #scroll {
        margin: 0px;
        padding: 10px;
        border: none;
        background-color: @base;
      }

      /* Input */
      #input {
        margin: 5px 20px;
        padding: 10px;
        border: none;
        border-radius: 0.1em;
        color: @text;
        background-color: @base;
        animation: fadeIn 0.5s ease-in-out both;
      }

      #input image {
          border: none;
          color: @red;
      }

      #input * {
        outline: 4px solid @red!important;
      }

      /* Text */
      #text {
        margin: 5px;
        border: none;
        color: @text;
        animation: fadeIn 0.5s ease-in-out both;
      }

      #entry {
        background-color: @base;
      }

      #entry arrow {
        border: none;
        color: @lavender;
      }

      /* Selected Entry */
      #entry:selected {
        border: 0.11em solid @lavender;
      }

      #entry:selected #text {
        color: @mauve;
      }

      #entry:drop(active) {
        background-color: @lavender!important;
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

  ##
  # Applets
  ##
  services.network-manager-applet.enable = true;

  ##
  # Wayland configuration
  ##
  wayland.windowManager.hyprland = {
    enable = true;

    settings = {
      source = hyprlandThemeConf;

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
      "$menu" = "wofi";

      # TODO: probably use these at some point
      # $fileManager = dolphin

      #################
      ### AUTOSTART ###
      #################

      # Autostart necessary processes (like notifications daemons, status bars, etc.)
      # Or execute your favorite apps at launch like this:

      exec-once = [
        "hyprpaper"
        "waybar"
        "[workspace 1 silent] $terminal"
        "[workspace 2 silent] $browser"
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
        "col.active_border" = "$green $sapphire 45deg";
        "col.inactive_border" = "$overlay0";

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
