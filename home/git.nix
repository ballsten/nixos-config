{ pkgs, ... }:

{
  home.packages = with pkgs; [
    lazygit
  ];

  programs.git = {
    enable = true;
    userEmail = "andrew@theaker.name";
    userName = "Andrew Theaker";
  };
}
