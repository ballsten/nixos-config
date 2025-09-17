#
# Waybar configuration - slashes
# https://github.com/Jan-Aarela/.dotfiles/blob/main/hypr/themes/Mocha/waybar.jsonc
# https://github.com/Jan-Aarela/.dotfiles/blob/main/hypr/themes/Mocha/waybar.css
##
{
  pkgs,
  ...
}:
{
  #install volume control
  home.packages = with pkgs; [
    pavucontrol
    wttrbar
  ];

  programs.waybar = {
    enable = true;
    settings = [
      {
        # // MAIN BAR //
        "layer" = "top";
        "position" = "bottom";
        "name" = "main";

        "modules-left" = [
          "group/tray"
          "custom/spacer3"
          "custom/spacer2"
          "hyprland/workspaces"
          "custom/spacer2"
          "custom/spacer3"
          "hyprland/submap"
          "hyprland/window"
        ];

        "modules-right" = [
          "custom/spacer1"
          "cpu"
          "temperature"
          # "custom/nvidia"
          "group/storage"
          "network#info"
          "custom/spacer1"
          "pulseaudio#input"
          "pulseaudio#output"
          "custom/spacer1"
          "backlight"
          "battery"
          "custom/spacer1"
          "custom/weather"
          "clock"
        ];

        # // Modules
        "group/tray" = {
          "orientation" = "horizontal";
          "drawer" = {
            "transition-duration" = "500";
            "transition-left-to-right" = "true";
            "children-class" = "drawer-child";
            #"click-to-reveal": "false"
          };
          "modules" = [
            "custom/trayicon"
            "tray"
          ];
        };

        "tray" = {
          "icon-size" = 17;
          "spacing" = 8;
        };

        "custom/trayicon" = {
          "format" = "";
          "tooltip" = false;
        };

        "hyprland/workspaces" = {
          "disable-scroll-wraparound" = true;
          "smooth-scrolling-threshold" = 4;
          "enable-bar-scroll" = true;
          "format" = "{icon}";
          "show-special" = true;
          "special-visible-only" = false;
          "format-icons" = {
            "magic" = " ";
            "10" = "󰊴 ";
          };
        };

        "hyprland/submap" = {
          "always-on" = true;
          "default-submap" = "";
          "format" = "{}";
          "format-RESIZE" = "{}lol";
          "tooltip" = false;
        };

        "hyprland/window" = {
          "format" = "{title}";
          "max-length" = 48;
          "tooltip" = false;
          "icon" = true;
          "icon-size" = 18;
        };

        "cpu" = {
          "interval" = 4;
          "format" = "  {usage}%";
          "states" = {
            "warning" = 80;
            "critical" = 95;
          };
        };

        "temperature" = {
          "critical-threshold" = 90;
          "interval" = 4;
          "format" = "{icon} {temperatureC}°";
          "format-icons" = [
            ""
            ""
            ""
            ""
            ""
          ];
          "tooltip" = false;
        };

        "group/storage" = {
          "orientation" = "horizontal";
          "drawer" = {
            "transition-duration" = "500";
            "transition-left-to-right" = "true";
            "children-class" = "drawer-child";
            # "click-to-reveal"= "false"
          };
          "modules" = [
            "memory#ram"
            "memory#swap"
            "disk"
          ];
        };

        "memory#ram" = {
          "interval" = 4;
          "format" = "   {percentage}%";
          "states" = {
            "warning" = 80;
            "critical" = 95;
          };
          "tooltip" = "{}";
          "tooltip-format" = "{used}/{total} GiB";
        };

        "memory#swap" = {
          "interval" = 16;
          "format" = "󰾵  {swapPercentage}%";
          "tooltip" = "{}";
          "tooltip-format" = "{swapUsed}/{swapTotal}GiB";
        };

        "disk" = {
          "interval" = 16;
          "format" = "  {percentage_used}%";
          "tooltip" = "{}";
          "tooltip-format" = "Free {free}";
          "states" = {
            "warning" = 85;
            "critical" = 95;
          };
        };

        "network#info" = {
          "interval" = 2;
          "format" = "󱘖  Offline";
          "format-wifi" = "{icon}  {bandwidthDownBits}";
          "format-ethernet" = "󰈀  {bandwidthDownBits}";
          "min-length" = 11;
          "tooltip" = "{}";
          "tooltip-format-wifi" =
            "{ifname}\n{essid}\n{signalStrength}% \n{frequency} GHz\n󰇚 {bandwidthDownBits}\n󰕒 {bandwidthUpBits}";
          "tooltip-format-ethernet" = "{ifname}\n󰇚 {bandwidthDownBits} \n󰕒 {bandwidthUpBits}";
          "format-icons" = [
            "󰤫"
            "󰤟"
            "󰤢"
            "󰤥"
            "󰤨"
          ];
          "states" = {
            "normal" = 25;
          };
        };

        "pulseaudio#output" = {
          "format" = "{icon}  {volume}%";
          "format-bluetooth" = "{icon}  {volume}%";
          "format-source-muted" = "{volume}";
          "format-icons" = {
            "headphone" = " ";
            "hands-free" = " ";
            "headset" = " ";
            "phone" = " ";
            "portable" = " ";
            "car" = " ";
            "default" = [
              " "
              " "
            ];
          };
          # "on-click-right"= "pactl set-sink-mute @DEFAULT_SINK@ toggle";
          # "on-click"= "pwvucontrol & aplay ~/.config/sounds/interact.wav";
          "tooltip" = true;
          "scroll-step" = 5;
        };

        "pulseaudio#input" = {
          "format" = " {icon} {format_source}%";
          "format-source" = "{volume}";
          "format-source-muted" = "{volume}";
          # "on-scroll-up"= "sh -c 'vol=$(pactl get-source-volume @DEFAULT_SOURCE@ | grep -oP \"\\d+(?=%)\" | head -1); if [ \"$vol\" -lt 100 ]; then pactl set-source-volume @DEFAULT_SOURCE@ +5%; fi'";
          # "on-scroll-down"= "pactl set-source-volume @DEFAULT_SOURCE@ -5%";
          "max-volume" = "100";
          # "on-click-right"= "pactl set-source-mute @DEFAULT_SOURCE@ toggle";
          # "on-click"= "pwvucontrol & aplay ~/.config/sounds/interact.wav";
          "tooltip-format" = "{source_desc}";
        };

        "backlight" = {
          "device" = "intel_backlight";
          "format" = "{icon} {percent}%";
          "format-icons" = [
            "󱩎 "
            "󱩑 "
            "󱩓 "
            "󱩕 "
            "󰛨 "
          ];
          "scroll-step" = 5;
        };

        "battery" = {
          "format" = "{icon} {capacity}%";
          "format-icons" = [
            " "
            " "
            " "
            " "
            " "
          ];
        };

        "custom/weather" = {
          "format" = "{}°";
          "tooltip" = true;
          "interval" = 1800;
          "exec" = "wttrbar --nerd --location \"Newcastle Australia\"";
          "return-type" = "json";
        };

        "clock" = {
          "interval" = 1;
          "format" = "  {:%H:%M    %d.%m}";
          "tooltip-format" = "{:%d.%m.%Y   Week %W}\n\n<tt><small>{calendar}</small></tt>";
          "calendar" = {
            "mode" = "month";
            "mode-mon-col" = 3;
            "weeks-pos" = "right";
            "on-scroll" = 1;
            "format" = {
              "months" = "<span color='#cba6f7'><b>{}</b></span>";
              "days" = "<span color='#cdd6f4'><b>{}</b></span>";
              "weeks" = "<span color='#94e2d5'> W{}</span>";
              "weekdays" = "<span color='#f9e2af'><b>{}</b></span>";
              "today" = "<span color='#f5e0dc'><b><u>{}</u></b></span>";
            };
          };
        };

        "custom/spacer1" = {
          "format" = " \\\\ ";
          "tooltip" = false;
        };

        "custom/spacer2" = {
          "format" = " ";
          "tooltip" = false;
        };

        "custom/spacer3" = {
          "format" = " // ";
          "tooltip" = false;
        };
      }
    ];
    # TODO: streamline styles
    style = ''
      /* vim:fileencoding=utf-8:foldmethod=marker
      */

      /* Define colors */ /* {{{ */
      @define-color background  rgba(21, 21, 32, 0.75);
      /* @define-color background  #151520; */
      @define-color warning     #f38ba8;
      @define-color caution     #45475a;
      @define-color performance #f5c2e7;
      @define-color audio       #cba6f7;
      @define-color misc        #94e2d5;
      @define-color date        #a6e3a1;
      @define-color work        #b4befe;
      @define-color window      #b4befe;
      @define-color resize      #eba0ac;
      @define-color process     #89b4fa;
      /* }}} */

      /* Reset all styles */ /* {{{ */
      * {
        border: none;
        border-radius: 0;
        min-height: 0;
        margin: 0;
        padding: 0;
        box-shadow: none;
        text-shadow: none;
      } /* }}} */

      /* Main bar keyframes */ /* {{{ */
      /* Keyframes for main bar criticals */
      @keyframes blink-critical-text {
        to {
          color: @warning;
        }
      }

      /* Keyframes for main bar modifiers */
      @keyframes blink-modifier-text {
        to {
          color: @caution;
        }
      } /* }}} */

      /* Main bar defaults */ /* {{{ */
      #waybar.main {
        background: @background;
        font-family: "FiraCode Mono Nerd Font";
        font-size: 10pt;
        font-weight: 500;
      }

      #waybar.main button {
        font-family: FiraCode Mono Nerd Font;
        font-size: 10pt;
        font-weight: 500;
        transition: all 0.15s ease-in-out;
      } /* }}} */

      /* Main bar modules */ /* {{{ */
      #waybar.main #custom-nvidia,
      #waybar.main #custom-weather,
      #waybar.main #custom-weather,
      #waybar.main #battery,
      #waybar.main #keyboard-state,
      #waybar.main #network,
      #waybar.main #battery,
      #waybar.main #backlight,
      #waybar.main #clock,
      #waybar.main #cpu,
      #waybar.main #language,
      #waybar.main #memory.swap,
      #waybar.main #memory.ram,
      #waybar.main #submap,
      #waybar.main #pulseaudio,
      #waybar.main #temperature,
      #waybar.main #tray,
      #waybar.main #window,
      #waybar.main #disk {
        padding-left: 8pt;
        padding-right: 8pt;
        padding-bottom: 4px;
        padding-top: 4px;
        background: transparent;
      }

      #waybar.main #tray {
        padding-right: 6pt;
      }

      #waybar.main #custom-weather {
        padding-right: 3pt;
      }
      /* }}} */

      /* Module colors */ /* {{{ */
      #waybar.main #custom-nvidia,
      #waybar.main #cpu,
      #waybar.main #temperature,
      #waybar.main #memory.ram,
      #waybar.main #memory.swap,
      #waybar.main #disk,
      #waybar.main #network {
        color: @performance;
      }

      #waybar.main #pulseaudio {
        color: @audio;
      }

      #waybar.main #battery,
      #waybar.main #language,
      #waybar.main #backlight,
      #waybar.main #battery {
        color: @misc;
      }

      #waybar.main #custom-weather,
      #waybar.main #clock {
        color: @date;
      }

      #waybar.main #window {
        color: @window;
        margin-top: -0px;
      }

      #waybar.main #network.info {
        padding-right: 10px;
        padding-left: 10px;
        color: @caution;
        background: transparent;
      }

      #waybar.main #network.info.wifi.normal,
      #waybar.main #network.info.ethernet {
        color: @performance;
        padding-right: 15px;
      }

      #waybar.main #network.info.wifi {
        color: @warning;
        padding-right: 15px;
      } /* }}} */

      /* Submap */ /* {{{ */
      #waybar.main #submap.󰲏 {
        color: @resize;
        animation-iteration-count: infinite;
        animation-direction: alternate;
        animation-name: blink-modifier-text;
        animation-duration: 1s;
        animation-timing-function: steps(15);
      }

      #waybar.main #submap. {
        color: @date;
        animation-iteration-count: infinite;
        animation-direction: alternate;
        animation-name: blink-modifier-text;
        animation-duration: 1s;
        animation-timing-function: steps(15);
      }
      /* }}} */

      /* Main bar criticals */ /* {{{ */
      #waybar.main #custom-nvidia.critical,
      #waybar.main #custom-battery.critical,
      #waybar.main #workspaces button.urgent,
      #waybar.main #workspaces button.special.urgent,
      #waybar.main #memory.swap.critical,
      #waybar.main #memory.ram.critical,
      #waybar.main #cpu.critical,
      #waybar.main #temperature.critical,
      #waybar.main #battery.critical.discharging {
        color: @caution;
        animation-iteration-count: infinite;
        animation-direction: alternate;
        animation-name: blink-critical-text;
        animation-duration: 1s;
        animation-timing-function: steps(15);
      } /* }}} */

      /* Main bar warnings */ /* {{{ */
      #waybar.main #pulseaudio.output.muted,
      #waybar.main #pulseaudio.input.source-muted {
        color: @caution;
      }

      #waybar.main #custom-battery.warning,
      #waybar.main #battery.warning.discharging {
        color: @warning;
      } /* }}} */

      /* Battery chargin */ /* {{{ */
      #waybar.main #custom-battery.charging {
        color: @misc;
        animation-iteration-count: infinite;
        animation-direction: alternate;
        animation-name: blink-modifier-text;
        animation-duration: 1s;
        animation-timing-function: steps(15);
      } /* }}} */

      /* Workspace */ /* {{{ */
      /* Default workspace settings */
      #waybar.main #workspaces button {
        color: @caution;
        background: transparent;
        border: 1.5px solid transparent;
        padding-left: 2pt;
        padding-right: 2pt;
        border-radius: 16px;
        margin-bottom: 8px;
        margin-top: 8px;
        margin-left: 4px;
        margin-right: 4px;
        transition: all 0.25s ease;
      }

      /* Focused workspace */
      #waybar.main #workspaces button.visible {
        color: @window;
      }

      /* Focused workspace & monitor */
      #waybar.main #workspaces button.active {
        color: @window;
        border: 1.5px solid @caution;
      }

      /* Style when cursor is on the button */
      #waybar.main #workspaces button:hover {
        color: @window;
      }

      /* Special workplace animation */
      #waybar.main #workspaces button.special.active {
        border: 1.5px solid transparent;
        color: @window;
        transition: all 0s ease;
        animation-iteration-count: infinite;
        animation-direction: alternate;
        animation-name: blink-modifier-text;
        animation-duration: 1s;
        animation-timing-function: steps(15);
      } /* }}} */

      /* Custom slashes as spacers */ /* {{{ */
      #waybar.main #custom-spacer1,
      #waybar.main #custom-spacer2,
      #waybar.main #custom-spacer3 {
        font-size: 10pt;
        font-weight: bold;
        color: @caution;
        background: transparent;
      }
      /* }}} */

      /* Custom tray icon */ /* {{{ */
      #waybar.main #custom-trayicon {
        font-size: 11pt;
        font-weight: bold;
        font-style: italic;
        color: @process;
        background: transparent;
        padding-right: 6pt;
        padding-left: 2pt;
      }
      /* }}} */

      /* Tooltip */ /* {{{ */
      tooltip {
        background: @background;
        border: 3px solid @caution;
        border-radius: 8px;
        font-weight: 500;
        font-family: "FiraCode Mono Nerd Font";
      }

      #waybar.main #tray menu {
        background: @background;
        border: 3px solid @caution;
        border-radius: 8px;
      } /* }}} */

      /* Indicator bar keyframes */ /* {{{ */
      @keyframes blink-critical-battery {
        to {
          border-color: @warning;
        }
      }

      @keyframes blink-warning-battery {
        to {
          border-color: @warning;
        }
      }

      @keyframes blink-discharging-battery {
        to {
          border-color: @warning;
        }
      }

      @keyframes blink-charging-battery {
        to {
          border-color: @misc;
        }
      }

      @keyframes blink-full-battery {
        to {
          border-color: @misc;
        }
      } /* }}} */

      /* indicator bar battery module */ /* {{{ */

      /* Set defaults for indicator bar */
      #waybar.indicator {
        font-size: 27px;
        /* This makes indicator thicker */
        color: rgba(0, 0, 0, 0);
        background: rgba(0, 0, 0, 0);
      }

      /* Set "battery bar" style */
      #waybar.indicator #custom-batteryindicator {
        border: 2.5px solid @caution;
        background: @background;
        border-radius: 8pt;
        padding-left: 2237.5px;
        /* Use this for padding:  */
        /* (H_rez / scaling) - L_margin -R_margin - 2 * border - (font-size / 2)*/
        /* For example: (2880px / 1.25) - 24 - 24 - 2 * 2.5 - (27 / 2) = 2237.5px */
      }

      /* Blink red when battery is very low */
      #waybar.indicator #custom-batteryindicator.critical {
        animation-iteration-count: infinite;
        animation-direction: alternate;
        animation-name: blink-critical-battery;
        animation-duration: 1s;
        animation-timing-function: steps(15);
      }

      /* Blink red twice when battry is low battery */
      #waybar.indicator #custom-batteryindicator.warning {
        animation-iteration-count: 4;
        animation-direction: alternate;
        animation-name: blink-warning-battery;
        animation-duration: 0.2s;
        animation-timing-function: steps(15);
      }

      /* Blink once red when disconnected from AC */
      #waybar.indicator #custom-batteryindicator.discharging {
        animation-iteration-count: 2;
        animation-direction: alternate;
        animation-name: blink-discharging-battery;
        animation-duration: 0.3s;
        animation-timing-function: steps(15);
      }

      /* Blink once cyan when plugged to AC */
      #waybar.indicator #custom-batteryindicator.charging {
        animation-iteration-count: 2;
        animation-direction: alternate;
        animation-name: blink-charging-battery;
        animation-duration: 0.3s;
        animation-timing-function: steps(15);
      }

      /* Blink cyan twice when battery is full */
      #waybar.indicator #custom-batteryindicator.full {
        animation-iteration-count: 4;
        animation-direction: alternate;
        animation-name: blink-full-battery;
        animation-duration: 0.2s;
        animation-timing-function: steps(15);
      } /* }}} */
    '';
  };
}
