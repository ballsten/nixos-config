# base user configuration for stylix
# each feature is expected to provide its own overrides
{
  inputs,
  config,
  pkgs,
  ...
}:

let
  inherit (inputs) tinted-schemes;
in
{
  # install fonts
  home.packages = with pkgs.nerd-fonts; [
    fira-code
    fira-mono
  ];

  stylix = {
    image = ../../resources/images/wallpaper-neon-city.jpg;
    base16Scheme = "${tinted-schemes}/base16/spaceduck.yaml";
    polarity = "dark";

    fonts = {
      serif = {
        package = pkgs.nerd-fonts.fira-code;
        name = "FiraCode Nerd Font";
      };
      sansSerif = config.stylix.fonts.serif;
      emoji = config.stylix.fonts.serif;
      monospace = {
        package = pkgs.nerd-fonts.fira-mono;
        name = "FiraMono Nerd Font";
      };
    };
  };
}
