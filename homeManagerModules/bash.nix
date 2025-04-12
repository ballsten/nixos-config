{ pkgs, ... }:

{
  home.packages = with pkgs; [
  ];

  programs.bash = {
    enable = true;
    enableCompletion = true;
  };
}
