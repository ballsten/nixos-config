{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.myHomeManager.features.hyprland;
  cursors = pkgs.rose-pine-hyprcursor;
in
{
  options = {
    myHomeManager.features.hyprland = {
      terminal = lib.mkOption {
        type = lib.types.str;
        default = "wezterm";
        description = "the default terminal program for hyprland";
      };
      suspendEnable = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Enable the use of suspend in hypridle configuration";
      };
      monitors = lib.mkOption {
        type = lib.types.lines;
        default = /* lua */ ''
          hl.monitor({ output = "", mode = "preferred", position = "auto", scale = 1 })
        '';
        description = "Use to override the montior settings";
      };
    };
  };

  home.packages = with pkgs; [
    hyprpicker
    hyprshutdown
    wl-clipboard
    networkmanagerapplet
    hicolor-icon-theme
    cursors
  ];

  ##
  # Main applications
  ##

  # TODO: modularize these (terminal already done) but enable programs
  programs.firefox = {
    enable = true;
    configPath = "${config.xdg.configHome}/mozilla/firefox";
  };
  stylix.targets.firefox = {
    profileNames = [ "default" ];
    fonts.enable = false;
  };

  ##
  # Applets
  ##
  # TODO: trying stuff
  services.network-manager-applet.enable = true;

  ##
  # Cursor configuration
  ##
  home.pointerCursor = {
    name = cursors.name;
    package = cursors;
    hyprcursor.enable = true;
  };

  ##
  # Wayland configuration
  ##
  wayland.windowManager.hyprland = {
    enable = true;

    configType = "lua";

    extraConfig = /* lua */ ''
        --
        -- Variables
        --

        -- set main modifier key
        local mod = "SUPER"

        -- set programs
        local terminal = "wezterm"
        local browser = "firefox"
        local lockscreen = "hyprlock"
        local menu = "rofi -show drun"

        --
        -- Monitors
        --
        ${cfg.monitors}

        --
        -- Autostart
        --
        hl.on("hyprland.start", function()
          hl.exec_cmd(terminal, { workspace = 1 }) 
          hl.exec_cmd(browser, { workspace = 2}) 
        end)
        
        --
        -- Keybinds
        --

        -- open programs
        hl.bind(mod .. " + T", hl.dsp.exec_cmd(terminal))
        hl.bind(mod .. " + F", hl.dsp.exec_cmd(browser))
        hl.bind(mod .. " + L", hl.dsp.exec_cmd(lockscreen))
        hl.bind(mod .. " + R", hl.dsp.exec_cmd(menu))

        -- close things
        hl.bind(mod .. " + Q", hl.dsp.window.close())
        hl.bind(mod .. " + M", hl.dsp.exec_cmd("hyprshutdown"))

        -- dwindle things
        hl.bind(mod .. " + P", hl.dsp.window.pseudo())
        hl.bind(mod .. " + A", hl.dsp.layout("togglesplit"))

        -- manage windows
        hl.bind(mod .. " + V", hl.dsp.window.float({ action = "toggle" }))
        hl.bind(mod .. " + SHIFT + F", hl.dsp.window.fullscreen({ action = "toggle" }))
        hl.bind(mod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
        hl.bind(mod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

        -- change workspace
        hl.bind(mod .. " + 1", hl.dsp.focus({ workspace = 1}))
        hl.bind(mod .. " + 2", hl.dsp.focus({ workspace = 2}))
        hl.bind(mod .. " + 3", hl.dsp.focus({ workspace = 3}))
        hl.bind(mod .. " + 4", hl.dsp.focus({ workspace = 4}))
        hl.bind(mod .. " + 5", hl.dsp.focus({ workspace = 5}))
        hl.bind(mod .. " + 6", hl.dsp.focus({ workspace = 6}))
        hl.bind(mod .. " + 7", hl.dsp.focus({ workspace = 7}))
        hl.bind(mod .. " + 8", hl.dsp.focus({ workspace = 8}))
        hl.bind(mod .. " + 9", hl.dsp.focus({ workspace = 9}))
        hl.bind(mod .. " + 0", hl.dsp.focus({ workspace = 10}))

      -- move window to new workspace
        hl.bind(mod .. " + SHIFT + 1", hl.dsp.window.move({ workspace = 1}))
        hl.bind(mod .. " + SHIFT + 2", hl.dsp.window.move({ workspace = 2}))
        hl.bind(mod .. " + SHIFT + 3", hl.dsp.window.move({ workspace = 3}))
        hl.bind(mod .. " + SHIFT + 4", hl.dsp.window.move({ workspace = 4}))
        hl.bind(mod .. " + SHIFT + 5", hl.dsp.window.move({ workspace = 5}))
        hl.bind(mod .. " + SHIFT + 6", hl.dsp.window.move({ workspace = 6}))
        hl.bind(mod .. " + SHIFT + 7", hl.dsp.window.move({ workspace = 7}))
        hl.bind(mod .. " + SHIFT + 8", hl.dsp.window.move({ workspace = 8}))
        hl.bind(mod .. " + SHIFT + 9", hl.dsp.window.move({ workspace = 9}))
        hl.bind(mod .. " + SHIFT + 0", hl.dsp.window.move({ workspace = 10}))

        -- move focus
        hl.bind(mod .. " + LEFT", hl.dsp.focus({direction = "l"}))
        hl.bind(mod .. " + RIGHT", hl.dsp.focus({direction = "r"}))
        hl.bind(mod .. " + UP", hl.dsp.focus({direction = "u"}))
        hl.bind(mod .. " + DOWN", hl.dsp.focus({direction = "d"}))

        -- multimedia keys
        hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"))
        hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"))
        hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"))
        hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"))
        hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl s 10%+"))
        hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl s 10%-"))
        hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"))
        hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"))
        hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"))
        hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"))

        --
        -- Window rules
        --

        -- float the firefox picture in picture window
        hl.window_rule({
          match = {
            class = "^firefox$",
            title = "^[Pp]icture-in-[Pp]icture$"
          },
          float = true,
          size = { 854, 480 },
          move = { "monitor_w - 854 - 20", "monitor_h - 480 - 70" },
          pin = true
        })
        
        --
        -- Look and feel
        --

        -- note colors will be done by stylix

        hl.config({
          general = {
            gaps_in = 5,
            gaps_out = 20,
            border_size = 2,
            resize_on_border = false,
            allow_tearing = false,
            layout = "dwindle",
          },
          decoration = {
            rounding = 10,
            active_opacity = 1.0,
            inactive_opacity = 1.0,
            shadow = {
              enabled = true,
              range = 4,
              render_power = 3,
            },

            blur = {
              enabled = true,
              size = 3,
              passes = 1,
              vibrancy = 0.1696,
            }
          },
          animations = {
            enabled = true,
            bezier = {
              "easeOutQuint,0.23,1,0.32,1",
              "easeInOutCubic,0.65,0.05,0.36,1",
              "linear,0,0,1,1",
              "almostLinear,0.5,0.5,0.75,1.0",
              "quick,0.15,0,0.1,1"
            },
            animation = {
              "global, 1, 10, default",
              "border, 1, 5.39, easeOutQuint",
              "windows, 1, 4.79, easeOutQuint",
              "windowsIn, 1, 4.1, easeOutQuint, popin 87%",
              "windowsOut, 1, 1.49, linear, popin 87%",
              "fadeIn, 1, 1.73, almostLinear",
              "fadeOut, 1, 1.46, almostLinear",
              "fade, 1, 3.03, quick",
              "layers, 1, 3.81, easeOutQuint",
              "layersIn, 1, 4, easeOutQuint, fade",
              "layersOut, 1, 1.5, linear, fade",
              "fadeLayersIn, 1, 1.79, almostLinear",
              "fadeLayersOut, 1, 1.39, almostLinear",
              "workspaces, 1, 1.94, almostLinear, fade",
              "workspacesIn, 1, 1.21, almostLinear, fade",
              "workspacesOut, 1, 1.94, almostLinear, fade"
            }
          },
          dwindle = {
            preserve_split = true
          },
          misc = {
            force_default_wallpaper = 0,
            disable_hyprland_logo = true,
          }
        });

        --
        -- Input
        --

        hl.config({
          input = {
            kb_layout = "us",
            kb_variant = "",
            kb_model = "",
            kb_options = "",
            kb_rules = "",

            follow_mouse = 1,

            sensitivity = 0,

            touchpad = {
              natural_scroll = true,
            }
          }
        });

        --
        -- GAMING MODE
        --

        -- workspace rules
        -- hl.workspace_rule({ workspace = "name:gaming", monitor = "DP-2", default = true })
        hl.workspace_rule({ workspace = "name:mono", monitor = "DP-3", layout = "monocle" })


        hl.bind(mod .. " + SHIFT + G", hl.dsp.window.move({ workspace = "name:mono"}))
        hl.bind(mod .. " + G", hl.dsp.focus( { workspace = "name:mono" }))
        hl.bind(mod .. " + TAB", hl.dsp.layout("cyclenext"))

        

    '';

    #   #################
    #   ### AUTOSTART ###
    #   #################

    #   # Autostart necessary processes (like notifications daemons, status bars, etc.)
    #   # Or execute your favorite apps at launch like this:

    #   #####################
    #   ### LOOK AND FEEL ###
    #   #####################

    #   # Ref https://wiki.hyprland.org/Configuring/Workspace-Rules/
    #   # "Smart gaps" / "No gaps when only"
    #   # uncomment all if you wish to use that.
    #   # workspace = w[tv1], gapsout:0, gapsin:0
    #   # workspace = f[1], gapsout:0, gapsin:0
    #   # windowrulev2 = bordersize 0, floating:0, onworkspace:w[tv1]
    #   # windowrulev2 = rounding 0, floating:0, onworkspace:w[tv1]
    #   # windowrulev2 = bordersize 0, floating:0, onworkspace:f[1]
    #   # windowrulev2 = rounding 0, floating:0, onworkspace:f[1]

    #   ###################
    #   ### KEYBINDINGS ###
    #   ###################

    #     # Example special workspace (scratchpad)
    #     "$mainMod, S, togglespecialworkspace, magic"
    #     "$mainMod SHIFT, S, movetoworkspace, special:magic"

    #     # Scroll through existing workspaces with mainMod + scroll
    #     "$mainMod, mouse_down, workspace, e+1"
    #     "$mainMod, mouse_up, workspace, e-1"
    #   ];

    #   ##############################
    #   ### WINDOWS AND WORKSPACES ###
    #   ##############################

    #   # See https://wiki.hyprland.org/Configuring/Window-Rules/ for more
    #   # See https://wiki.hyprland.org/Configuring/Workspace-Rules/ for workspace rules

    #   # Example windowrule v1
    #   # windowrule = float, ^(kitty)$

    #   # Example windowrule v2
    #   # windowrulev2 = float,class:^(kitty)$,title:^(kitty)$

    #   #windowrule = [
    #   # Ignore maximize requests from apps. You'll probably like this.
    #   # "suppressevent maximize, class:.*"

    #   # Fix some dragging issues with XWayland
    #   #  "nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"
    #   #];
    # };

  };
}
