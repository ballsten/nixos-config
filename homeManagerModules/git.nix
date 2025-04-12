{ pkgs, ... }:

{
  home.packages = with pkgs; [
    lazygit
  ];

  home.shellAliases = {
    lg = "lazygit";
  };

  programs.git = {
    enable = true;
    userEmail = "andrew@theaker.name";
    userName = "Andrew Theaker";
  };
}
