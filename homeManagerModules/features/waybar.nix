##
# Waybar configuration
##
{
  pkgs,
  ...
}:
{
  #install volume control
  home.packages = with pkgs; [
    pavucontrol
  ];
  # enable theme
  catppuccin.waybar.enable = true;

  programs.waybar = {
    enable = true;
    settings = {
      mainbar = {
        # ─────────────────────────────────────────────────────────────┤ header ├───
        layer = "top";
        position = "bottom";
        mode = "dock";
        # ──────────────────────────────────────────────────────────┤ positions ├───
        modules-left = [
          "custom/ws"
          "custom/left1"
          "hyprland/workspaces"
          "custom/right1"
          "custom/paddw"
          "hyprland/window"
        ];
        modules-center = [
          "custom/paddc"
          "custom/left2"
          "temperature"

          "custom/left3"
          "memory"

          "custom/left4"
          "cpu"
          "custom/leftin1"

          "custom/left5"
          "custom/distro"
          "custom/right2"

          "custom/rightin1"
          "idle_inhibitor"
          "clock#time"
          "custom/right3"

          "clock#date"
          "custom/right4"

          "disk"
          "custom/right5"
        ];
        modules-right = [
          "mpris"

          "custom/left6"
          "pulseaudio"

          "custom/left7"
          "backlight"

          "custom/left8"
          "battery"

          "custom/left9"
          "tray"

          "custom/leftin2"
          "custom/power"
        ];
        # ────────────────────────────────────────────────────────┤ window icon ├───
        "custom/ws" = {
          "format" = "  ";
          "min-length" = 3;
          "max-length" = 3;
        };
        # ─────────────────────────────────────────────────────────────┤ header ├───
        "hyprland/workspaces" = {
          "on-scroll-up" = "hyprctl dispatch workspace -1";
          "on-scroll-down" = "hyprctl dispatch workspace +1";
          persistent-workspaces = {
            "1" = [ ];
            "2" = [ ];
            "3" = [ ];
            "4" = [ ];
            "5" = [ ];
          };
        };
        # ─────────────────────────────────────────────────────────────┤ window ├───
        "hyprland/window" = {
          "format" = "{}";
          "tooltip" = false;
          "min-length" = 5;

          "rewrite" = {
            # ────────────────────────────────────────────────────────── desktop ───
            "" = "<span foreground='#89b4fa'> </span> Hyprland";

            # ───────────────────────────────────────────────────────── terminal ───
            "~" = "  Terminal";
            "fish" = "  Terminal";
            "wezterm" = "  Terminal";

            # ────────────────────────────────────────────────────────── browser ───
            "(.*)Mozilla Firefox" = "<span foreground='#f38ba8'>󰈹 </span> Firefox";
            "(.*) — Mozilla Firefox" = "<span foreground='#f38ba8'>󰈹 </span> $1";

            # ────────────────────────────────────────────────────── development ───

            "nvim" = "<span foreground='#a6e3a1'> </span> Neovim";
            "nvim (.*)" = "<span foreground='#a6e3a1'> </span> $1";

            "vim" = "<span foreground='#a6e3a1'> </span> Vim";
            "vim (.*)" = "<span foreground='#a6e3a1'> </span> $1";

            # ──────────────────────────────────────────────────────────── media ───
            "(.*).jpg" = "  $1.jpg";
            "(.*).png" = "  $1.png";
            "(.*).svg" = "  $1.svg";

            # ─────────────────────────────────────────────────────────── social ───

            "• Discord(.*)" = "Discord$1";
            "(.*)Discord(.*)" = "<span foreground='#89b4fa'> </span> $1Discord$2";

            "vesktop" = "<span foreground='#89b4fa'> </span> Discord";

            # ─────────────────────────────────────────────────────────── system ───
            "Authenticate" = "  Authenticate";
          };
        };
        # ────────────────────────────────────────────────────────┤ temperature ├───

        "temperature" = {
          "format" = " {temperatureC}°C";
        };
        # ─────────────────────────────────────────────────────────────┤ memory ├───

        "memory" = {
          "states" = {
            "warning" = 75;
            "critical" = 90;
          };

          "format" = "󰘚 {percentage}%";
          "format-critical" = "󰀦 {percentage}%";
          "tooltip" = false;
          # "tooltip-format"= "Memory Used= {used=0.1f} GB / {total=0.1f} GB";
          "interval" = 5;
          "min-length" = 7;
          "max-length" = 7;
        };

        # ────────────────────────────────────────────────────────────────┤ cpu ├───

        "cpu" = {
          "format" = "󰻠 {usage}%";
          "tooltip" = false;
          "interval" = 5;
          "min-length" = 6;
          "max-length" = 6;
        };

        # ─────────────────────────────────────────────────────────────┤ distro ├───

        "custom/distro" = {
          "format" = " ";
          "tooltip" = false;
        };

        # ─────────────────────────────────────────────────────┤ idle inhibitor ├───

        "idle_inhibitor" = {
          "format" = "{icon}";

          "format-icons" = {
            "activated" = "󰈈 ";
            "deactivated" = "󰈉 ";
          };

          "tooltip-format-activated" = "Presentation Mode";
          "tooltip-format-deactivated" = "Idle Mode";
          "start-activated" = false;
        };

        # ───────────────────────────────────────────────────────────────┤ time ├───

        "clock#time" = {
          "format" = "{:%H:%M}";
          "tooltip" = false;
          # "tooltip-format"= "Standard Time= {=%I=%M %p}";
          "min-length" = 6;
          "max-length" = 6;
        };

        # ───────────────────────────────────────────────────────────────┤ date ├───

        "clock#date" = {
          "format" = "󰨳 {:%d-%m}";
          "tooltip-format" = "<tt>{calendar}</tt>";

          "calendar" = {
            "mode" = "month";
            "mode-mon-col" = 6;
            "on-click-right" = "mode";

            "format" = {
              "months" = "<span color='#b4befe'><b>{}</b></span>";
              "weekdays" = "<span color='#a6adc8' font='7'>{}</span>";
              "today" = "<span color='#f38ba8'><b>{}</b></span>";
            };
          };

          "actions" = {
            "on-click" = "mode";
            "on-click-right" = "mode";
          };

          "min-length" = 8;
          "max-length" = 8;
        };

        # ──────────────────────────────────────────────────────────────┤ disk ├───

        "disk" = {
          "format" = " {percentage_free}%";
          "interval" = 30;
          "path" = "/";
          "max-length" = 5;
        };

        # ─────────────────────────────────────────────────────────┤ media info ├───

        "mpris" = {
          "format" = "{player_icon} {title} - {artist}";
          "format-paused" = "{status_icon} {title} - {artist}";

          "player-icons" = {
            "default" = "󰝚 ";
            "spotify" = "<span foreground='#a6e3a1'>󰓇 </span>";
            "firefox" = "<span foreground='#f38ba8'>󰗃 </span>";
          };
          "status-icons" = {
            "paused" = "<span color='#b4befe'>󰏤</span>";
          };

          "tooltip-format" = "Playing= {title} - {artist}";
          "tooltip-format-paused" = "Paused= {title} - {artist}";
          "min-length" = 5;
          "max-length" = 50;
        };

        # ──────────────────────────────────────────────────────┤ output device ├───

        "pulseaudio" = {
          "format" = "{icon} {volume}%";
          "format-muted" = "󰝟 {volume}%";

          "format-icons" = {
            "default" = [
              "󰕿"
              "󰖀"
              "󰕾"
            ];
            "headphone" = "󰋋";
            "headset" = "󰋋";
          };

          "tooltip-format" = "Device= {desc}";
          "on-click" = "pavucontrol";
          "min-length" = 6;
          "max-length" = 6;
        };

        # ─────────────────────────────────────────────────────────┤ brightness ├───

        "backlight" = {
          "format" = "{icon} {percent}%";
          "format-icons" = [
            ""
            ""
            ""
            ""
            ""
            ""
            ""
            ""
            ""
          ];
          "tooltip" = false;
          "min-length" = 6;
          "max-length" = 6;
        };

        # ────────────────────────────────────────────────────────────┤ battery ├───

        "battery" = {
          "states" = {
            "warning" = 20;
            "critical" = 10;
          };

          "format" = "{icon} {capacity}%";
          "format-icons" = [
            "󰂎"
            "󰁻"
            "󰁼"
            "󰁽"
            "󰁾"
            "󰁿"
            "󰂀"
            "󰂁"
            "󰂂"
            "󰁹"
          ];
          "format-charging" = " {capacity}%";

          "tooltip-format" = "Discharging= {time}";
          "tooltip-format-charging" = "Charging= {time}";
          "interval" = 1;
          "min-length" = 6;
          "max-length" = 6;
        };

        # ───────────────────────────────────────────────────────────────┤ tray ├───
        tray = {
          icon-size = 21;
          spacing = 10;
        };
        # ───────────────────────────────────────────────────────┤ power button ├───

        "custom/power" = {
          "format" = " ";
          "tooltip" = false;
          # "tooltip-format"= "Power Menu";
          "on-click" = "wlogout &";
        };

        # ────────────────────────────────────────────────────────────┤ padding ├───

        "custom/paddw" = {
          "format" = " ";
          "tooltip" = false;
        };

        "custom/paddc" = {
          "format" = " ";
          "tooltip" = false;
        };

        # ────────────────────────────────────────────────────────┤ left arrows ├───

        "custom/left1" = {
          "format" = "";
          "tooltip" = false;
        };
        "custom/left2" = {
          "format" = "";
          "tooltip" = false;
        };
        "custom/left3" = {
          "format" = "";
          "tooltip" = false;
        };
        "custom/left4" = {
          "format" = "";
          "tooltip" = false;
        };
        "custom/left5" = {
          "format" = "";
          "tooltip" = false;
        };
        "custom/left6" = {
          "format" = "";
          "tooltip" = false;
        };
        "custom/left7" = {
          "format" = "";
          "tooltip" = false;
        };
        "custom/left8" = {
          "format" = "";
          "tooltip" = false;
        };
        "custom/left9" = {
          "format" = "";
          "tooltip" = false;
        };

        # ───────────────────────────────────────────────────────┤ right arrows ├───

        "custom/right1" = {
          "format" = "";
          "tooltip" = false;
        };
        "custom/right2" = {
          "format" = "";
          "tooltip" = false;
        };
        "custom/right3" = {
          "format" = "";
          "tooltip" = false;
        };
        "custom/right4" = {
          "format" = "";
          "tooltip" = false;
        };
        "custom/right5" = {
          "format" = "";
          "tooltip" = false;
        };

        # ───────────────────────────────────────────────────────┤ left inverse ├───

        "custom/leftin1" = {
          "format" = "";
          "tooltip" = false;
        };
        "custom/leftin2" = {
          "format" = "";
          "tooltip" = false;
        };

        # ──────────────────────────────────────────────────────┤ right inverse ├───

        "custom/rightin1" = {
          "format" = "";
          "tooltip" = false;
        };
      };
    };
    style = ''
      /* ──────────────────────────────────────────────────────────────┤ colors ├───
      */
      /* Main Colors */
      @define-color white           #ffffff;
      @define-color black           #000000;
      @define-color shadow          shade(@base, 0.9);
      @define-color main-fg         @text;
      @define-color main-bg         @base;
      @define-color main-br         @text;

      @define-color active-bg       @overlay2;
      @define-color active-fg       @crust;

      @define-color hover-bg        @surface0;
      @define-color hover-fg        alpha(@text, 0.75);

      /* Module Colors */
      @define-color module-fg       @text;
      @define-color workspaces      @crust;

      @define-color temperature     @mantle;
      @define-color memory          @base;
      @define-color cpu             @surface0;
      @define-color distro-fg       shade(@green, 0.8);
      @define-color distro-bg       @overlay2;
      @define-color time            @surface0;
      @define-color date            @base;
      @define-color disk            @mantle;

      @define-color pulseaudio      @mantle;
      @define-color backlight       @base;
      @define-color battery         @surface0;
      @define-color tray            @surface2;
      @define-color power           @overlay2;

      /* State Colors */
      @define-color warning         @yellow;
      @define-color critical        @red;
      @define-color charging        @text;

      /* ───────────────────────────────────────────────────────────────┤ global ├───
      */
      * {
        min-height: 0;
        border: none;
        margin: 0;
        padding: 0;
      }

      /* ──────────────────────────────────────────────────────────┤ drop shadow ├───
      */
      window#waybar {
        background: @shadow;
      }

      /* ───────────────────────────────────────────────────────────┤ background ├───
      */
      window#waybar > box {
        background: @main-bg;
        margin: 2px;
      }

      /* ─────────────────────────────────────────────────────────────┤ tooltips ├───
      */
      tooltip {
        background: @main-bg;
        border: 1.5px solid @main-br;
        border-radius: 8px;
      }

      tooltip label {
        color: @main-fg;
        margin: -1.5px 3px;
      }

      /* ──────────────────────────────────────────────────────────────┤ general ├───
      */
      #custom-ws,
      #workspaces,
      #window,
      #temperature,
      #memory,
      #cpu,
      #idle_inhibitor,
      #clock,
      #disk,
      #bluetooth,
      #custom-update,
      #mpris,
      #pulseaudio,
      #backlight,
      #battery,
      #tray,
      #custom-power {
        opacity: 1;
        color: @module-fg;
        padding: 0 4px;
      }

      #custom-left1,
      #custom-left2,
      #custom-left3,
      #custom-left4,
      #custom-left5,
      #custom-left6,
      #custom-left7,
      #custom-left8,
      #custom-left9 {
        margin-bottom: 0;
        text-shadow: -2px 0 2px rgba(0, 0, 0, 0.5);
      }

      #custom-right1,
      #custom-right2,
      #custom-right3,
      #custom-right4,
      #custom-right5 {
        margin-bottom: 0;
        padding-right: 3px;
        text-shadow: 2px 0 2px rgba(0, 0, 0, 0.5);
      }

      /* ──────────────────────────────────────────────────────────┤ window icon ├───
      */
      #custom-ws {
        background: @main-bg;
      }

      #custom-ws:hover {
        color: @hover-fg;
      }

      /* ───────────────────────────────────────────────────────────┤ workspaces ├───
      */
      #custom-left1 {
        color: @workspaces;
        background: @main-bg;
        margin-bottom: 0;
        padding-left: 2px;
      }

      #workspaces {
        background: @workspaces;
      }

      #workspaces button {
        color: @module-fg;
        border-radius: 8px;
        box-shadow: none;
        margin: 2px 0;
        padding: 0 10px;
        transition: none;
      }

      #workspaces button:hover {
        color: @hover-fg;
        background: @hover-bg;
        text-shadow: none;
      }

      #workspaces button.active {
        color: @active-fg;
        background: @active-bg;
        text-shadow: 0 0 2px rgba(0, 0, 0, 0.6);
        box-shadow: 0 0 2px 1px rgba(0, 0, 0, 0.4);
        margin: 2px;
        padding: 0 20px;
      }

      #workspaces button.urgent {
        color: @warning;
      }

      #custom-right1 {
        color: @workspaces;
        background: @main-bg;
        text-shadow: 3px 0 2px rgba(0, 0, 0, 0.4);
        margin-bottom: 0;
      }

      /* ──────────────────────────────────────────────────────────┤ temperature ├───
      */
      #custom-paddc {
        padding-right: 22px;
      }

      #custom-left2 {
        color: @temperature;
        background: @main-bg;
        padding-left: 3px;
      }

      #temperature {
        background: @temperature;
        padding: 0 5px 0 5px;
      }

      /* ───────────────────────────────────────────────────────────────┤ memory ├───
      */
      #custom-left3 {
        color: @memory;
        background: @temperature;
        padding-left: 3px;
      }

      #memory {
        background: @memory;
        padding: 0 0 0 1px;
      }

      #memory.warning {
        color: @warning;
      }

      #memory.critical {
        color: @critical;
      }

      /* ──────────────────────────────────────────────────────────────────┤ cpu ├───
      */
      #custom-left4 {
        color: @cpu;
        background: @memory;
        padding-left: 3px;
      }

      #cpu {
        background: @cpu;
      }

      #custom-leftin1 {
        color: @cpu;
        margin-bottom: -1px;
      }

      /* ──────────────────────────────────────────────────────────┤ distro icon ├───
      */
      #custom-left5 {
        color: @distro-bg;
        background: @main-bg;
        text-shadow: none;
        margin-bottom: -2px;
        padding-left: 3px;
      }

      #custom-distro {
        color: @distro-fg;
        background: @distro-bg;
        margin: 0 0 0px 0;
        padding: 0 0 0 2px;
        text-shadow: 0 0 2.5px alpha(shade(@distro-fg, 0.3), 0.8);
      }

      #custom-right2 {
        color: @distro-bg;
        background: @main-bg;
        text-shadow: none;
        margin-bottom: -2px;
      }

      /* ─────────────────────────────────────────────────────────────────┤ time ├───
      */
      #custom-rightin1 {
        color: @time;
        margin-bottom: -1px;
      }

      #idle_inhibitor {
        background: @time;
        padding: 0 0 0 7px;
      }

      #idle_inhibitor:hover {
        color: @hover-fg;
      }

      #clock.time {
        background: @time;
        margin-left: -2px;
        padding: 0 3px 0 0;
      }

      #custom-right3 {
        color: @time;
        background: @date;
      }

      /* ─────────────────────────────────────────────────────────────────┤ date ├───
      */
      #clock.date {
        background: @date;
      }

      #clock.date:hover {
        color: @hover-fg;
      }

      #custom-right4 {
        color: @date;
        background: @tray;
      }

      /* ─────────────────────────────────────────────────────────────────┤ disk ├───
      */
      #disk {
        background: @tray;
        padding: 0 8px 0 5px;
      }

      #disk:hover {
        color: @hover-fg;
      }

      /* ───────────────────────────────────────────────────────────┤ media info ├───
      */
      #mpris {
        background: @main-bg;
        padding: 0 8px 0;
      }

      #mpris:hover {
        color: @hover-fg;
      }

      /* ────────────────────────────────────────────────────────┤ output device ├───
      */
      #custom-left6 {
        color: @pulseaudio;
        background: @main-bg;
        padding-left: 3px;
      }

      #pulseaudio {
        background: @pulseaudio;
      }

      #pulseaudio:hover {
        color: @hover-fg;
      }

      /* ───────────────────────────────────────────────────────────┤ brightness ├───
      */
      #custom-left7 {
        color: @backlight;
        background: @pulseaudio;
        padding-left: 2px;
      }

      #backlight {
        background: @backlight;
      }

      /* ──────────────────────────────────────────────────────────────┤ battery ├───
      */
      #custom-left8 {
        color: @battery;
        background: @backlight;
        padding-left: 2px;
      }

      #battery {
        color: @module-fg;
        background: @battery;
      }

      #battery.warning {
        color: @warning;
      }

      #battery.critical {
        color: @critical;
      }

      #battery.charging {
        color: @charging;
      }

      /* ─────────────────────────────────────────────────────────────────┤ tray ├───
      */

      #custom-left9 {
        color: @tray;
        background: @battery;
        padding-left: 2px;
      }

      #tray {
        color: @module-fg;
        background: @tray;
        padding: 0 10px;
      }

      /* ─────────────────────────────────────────────────────────┤ power button ├───
      */
      #custom-leftin2 {
        color: @tray;
        background: @main-bg;
        margin-bottom: -1px;
      }

      #custom-power {
        color: @main-bg;
        background: @power;
        text-shadow: 0 0 2px rgba(0, 0, 0, 0.6);
        box-shadow: 0 0 2px 1px rgba(0, 0, 0, 0.6);
        border-radius: 10px;
        margin: 4px 4px 4px 0;
        padding: 0 9px 0 12px;
      }

      #custom-power:hover {
        color: @hover-fg;
        background: @hover-bg;
        text-shadow: none;
        box-shadow: none;
      }

      /* ───────────────────────────────────────────────────────────┤ font sizes ├───
      */
      /*
        NOTE: Be careful when changing font sizes, as they can affect alignment.

        Try adjusting whole numbers first, then refine with decimals.

        If you increase or decrease a value, make the same change to all properties
        in this section to keep the layout consistent.
      */

      * {
        font-family: "FiraCode Nerd Font";
        font-size: 18px;
        font-weight: normal;
      }

      tooltip label,
      #window label,
      #mpris {
        font-weight: normal;
      }

      /* ──────────────────────────────────────────────────┤ left & right arrows ├───
      */
      #custom-left1,
      #custom-left2,
      #custom-left3,
      #custom-left4,
      #custom-left5,
      #custom-left6,
      #custom-left7,
      #custom-left8,
      #custom-left9,
      #custom-right1,
      #custom-right2,
      #custom-right3,
      #custom-right4,
      #custom-right5 {
        font-size: 24.5px;
      }

      /* ─────────────────────────────────────────────────┤ left & right inverse ├───
      */
      #custom-leftin1,
      #custom-leftin2,
      #custom-rightin1 {
        font-size: 24.5px;
      }

      /* ──────────────────────────────────────────────────────────┤ distro icon ├───
      */
      #custom-distro {
        font-size: 22px;
      }

      #custom-left5,
      #custom-right2 {
        font-size: 24.5px;
      }

    '';
  };

}
