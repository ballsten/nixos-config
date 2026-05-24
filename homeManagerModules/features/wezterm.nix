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
      config.hide_tab_bar_if_only_one_tab = true

      return config
    '';
  };
}
