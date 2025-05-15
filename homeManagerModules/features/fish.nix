##
# Fish shell configuration
##
{
  ...
}:
{
  catppuccin.fish.enable = true;
  programs.fish = {
    enable = true;
    generateCompletions = true;
  };

  # TODO: split this out
  programs.starship = {
    enable = true;
    enableFishIntegration = true;
    settings = {
      "$schema" = "https://starship.rs/config-schema.json";

      format = "[](green)\$os\$username\[](bg:sky fg:green)\$directory\[](bg:yellow fg:sky)\$git_branch\$git_status\[](fg:yellow bg:sapphire)\$c\$rust\$golang\$nodejs\$php\$java\$kotlin\$haskell\$python\[](fg:sapphire bg:blue)\$conda\[](fg:blue bg:lavender)\$time\[ ](fg:lavender)\$cmd_duration\$line_break\$character";

      palette = "catppuccin_mocha";

      os = {
        disabled = false;
        style = "bg:green fg:crust";

        symbols = {
          NixOS = "";
          Windows = "";
          Ubuntu = "󰕈";
          SUSE = "";
          Raspbian = "󰐿";
          Mint = "󰣭";
          Macos = "󰀵";
          Manjaro = "";
          Linux = "󰌽";
          Gentoo = "󰣨";
          Fedora = "󰣛";
          Alpine = "";
          Amazon = "";
          Android = "";
          Arch = "󰣇";
          Artix = "󰣇";
          CentOS = "";
          Debian = "󰣚";
          Redhat = "󱄛";
          RedHatEnterprise = "󱄛";
        };
      };
      username = {
        show_always = true;
        style_user = "bg:green fg:crust";
        style_root = "bg:green fg:crust";
        format = "[ $user]($style)";
      };

      directory = {
        style = "bg:sky fg:crust";
        format = "[ $path ]($style)";
        truncation_length = 3;
        truncation_symbol = "…/";

        substitutions = {
          "Documents" = "󰈙 ";
          "Downloads" = " ";
          "Music" = "󰝚 ";
          "Pictures" = " ";
          "Developer" = "󰲋 ";
        };
      };
      git_branch = {
        symbol = "";
        style = "bg:yellow";
        format = "[[ $symbol $branch ](fg:crust bg:yellow)]($style)";
      };

      git_status = {
        style = "bg:yellow";
        format = "[[($all_status$ahead_behind )](fg:crust bg:yellow)]($style)";
      };

      nodejs = {
        symbol = "";
        style = "bg:sapphire";
        format = "[[ $symbol( $version) ](fg:crust bg:sapphire)]($style)";
      };

      c = {
        symbol = " ";
        style = "bg:sapphire";
        format = "[[ $symbol( $version) ](fg:crust bg:sapphire)]($style)";
      };
      rust = {
        symbol = "";
        style = "bg:sapphire";
        format = "[[ $symbol( $version) ](fg:crust bg:sapphire)]($style)";
      };
      golang = {
        symbol = "";
        style = "bg:sapphire";
        format = "[[ $symbol( $version) ](fg:crust bg:sapphire)]($style)";
      };

      php = {
        symbol = "";
        style = "bg:sapphire";
        format = "[[ $symbol( $version) ](fg:crust bg:sapphire)]($style)";
      };
      java = {
        symbol = " ";
        style = "bg:sapphire";
        format = "[[ $symbol( $version) ](fg:crust bg:sapphire)]($style)";
      };
      kotlin = {
        symbol = "";
        style = "bg:sapphire";
        format = "[[ $symbol( $version) ](fg:crust bg:sapphire)]($style)";
      };
      haskell = {
        symbol = "";
        style = "bg:sapphire";
        format = "[[ $symbol( $version) ](fg:crust bg:sapphire)]($style)";
      };

      python = {
        symbol = "";
        style = "bg:sapphire";
        format = "[[ $symbol( $version)(\(#$virtualenv\)) ](fg:crust bg:sapphire)]($style)";
      };

      docker_context = {
        symbol = "";
        style = "bg:blue";
        format = "[[ $symbol( $context) ](fg:crust bg:blue)]($style)";
      };
      conda = {
        symbol = "  ";
        style = "fg:crust bg:blue";
        format = "$symbol$environment ]($style)";
        ignore_base = false;
      };

      time = {
        disabled = false;
        time_format = "%R";
        style = "bg:lavender";
        format = "[[  $time ](fg:crust bg:lavender)]($style)";
      };
      line_break = {
        disabled = false;
      };

      character = {
        disabled = false;
        success_symbol = "[❯](bold fg:green)";
        error_symbol = "[❯](bold fg:red)";
        vimcmd_symbol = "[❮](bold fg:green)";
        vimcmd_replace_one_symbol = "[❮](bold fg:lavender)";
        vimcmd_replace_symbol = "[❮](bold fg:lavender)";
        vimcmd_visual_symbol = "[❮](bold fg:yellow)";
      };

      cmd_duration = {
        show_milliseconds = true;
        format = " in $duration ";
        style = "bg:lavender";
        disabled = true;
        show_notifications = true;
        min_time_to_notify = 45000;
      };

      palettes.catppuccin_mocha = {
        rosewater = "#f5e0dc";
        flamingo = "#f2cdcd";
        pink = "#f5c2e7";
        mauve = "#cba6f7";
        red = "#f38ba8";
        maroon = "#eba0ac";
        peach = "#fab387";
        yellow = "#f9e2af";
        green = "#a6e3a1";
        teal = "#94e2d5";
        sky = "#89dceb";
        sapphire = "#74c7ec";
        blue = "#89b4fa";
        lavender = "#b4befe";
        text = "#cdd6f4";
        subtext1 = "#bac2de";
        subtext0 = "#a6adc8";
        overlay2 = "#9399b2";
        overlay1 = "#7f849c";
        overlay0 = "#6c7086";
        surface2 = "#585b70";
        surface1 = "#45475a";
        surface0 = "#313244";
        base = "#1e1e2e";
        mantle = "#181825";
        crust = "#11111b";
      };
    };
  };
}
