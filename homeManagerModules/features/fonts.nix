##
# Allow the user to specify the nerd font of their choice
##
{
  pkgs,
  lib,
  config,
  ...
}:
let
  fonts = {
    "FiraCode" = pkgs.nerd-fonts.fira-code;
    "Terminess" = pkgs.nerd-fonts.terminess-ttf;
  };
  cfg = config.myHomeManager.features.fonts;
in
{
  options = {
    myHomeManager.features.fonts = {
      nerdFont = lib.mkOption {
        type = lib.types.enum (builtins.attrNames fonts);
        default = "FiraCode";
        description = ''
          Nerd font to be used
        '';
      };
      nerdFontSize = lib.mkOption {
        type = lib.types.str;
        default = "12";
        description = ''
          Font size to be configured in various applications
        '';
      };
    };
  };

  config = {
    home.packages = [
      (builtins.getAttr cfg.nerdFont fonts)
    ];
  };
}
