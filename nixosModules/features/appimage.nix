##
# Install AppImage and GearLever
##
{ pkgs, ... }:
{
  programs.appimage = {
    enable = true;
    binfmt = true;
    package = pkgs.appimage-run.override {
      extraPkgs =
        pkgs: with pkgs; [
          icu
          xsel
          webkitgtk_4_1
        ];
    };
  };
}
