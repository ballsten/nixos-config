#
# Feature: wezterm
#
# Install and configure wezterm just how I like Install


{ pkgs, ... }:
{
  programs.wezterm = {
    enable = true;
    enableBashIntegration = true;
    extraConfig = ''
      local wezterm = require 'wezterm'
      local config = wezterm.config_builder()

      config.font = wezterm.font 'FiraCode Nerd Font Mono'

      return config
    '';
  };
}
