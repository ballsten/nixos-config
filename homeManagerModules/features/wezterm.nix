#
# Feature: wezterm
#
# Install and configure wezterm just how I like it


{ inputs, ... }:
{
  programs.wezterm = {
    enable = true;
    enableBashIntegration = true;
    extraConfig = ''
      local wezterm = require 'wezterm'
      local config = wezterm.config_builder()

      config.font = wezterm.font 'FiraCode Nerd Font Mono'
      
      config.hide_tab_bar_if_only_one_tab = true

      config.colors = dofile("${inputs.nixpkgs.legacyPackages.x86_64-linux.vimPlugins.cyberdream-nvim}/extras/wezterm/cyberdream.lua")

      return config
    '';
  };
}
