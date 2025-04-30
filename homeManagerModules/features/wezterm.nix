# Feature: wezterm
#
# Install and configure wezterm just how I like it

{ config, ... }:
let
  cfg = config.myHomeManager.features;
in
{
  programs.wezterm = {
    enable = true;
    enableBashIntegration = true;
    extraConfig = ''
      local wezterm = require 'wezterm'
      local config = wezterm.config_builder()

      config.font = wezterm.font '${cfg.fonts.nerdFont} Nerd Font Mono'
      config.font_size = ${cfg.fonts.nerdFontSize}

      config.hide_tab_bar_if_only_one_tab = true

      config.color_scheme = "Catppuccin Mocha"

      return config
    '';
  };
}
