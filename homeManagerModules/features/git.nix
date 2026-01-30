{ pkgs, ... }:

{
  home.shellAliases = {
    lg = "lazygit";
  };

  programs = {
    git = {
      enable = true;
      settings = {
        user = {
          email = "andrew@theaker.name";
          name = "ballsten";
        };
        pull.rebase = false;
        remote.origin.prune = true;
      };
    };
    lazygit = {
      enable = true;
      settings = {
        gui = {
          theme = {
            activeBorderColor = [
              "#a6e3a1"
              "bold"
            ];
            inactiveBorderColor = [ "#a6adc8" ];
            optionsTextColor = [ "#89b4fa" ];
            selectedLineBgColor = [ "#313244" ];
            cherryPickedCommitBgColor = [ "#45475a" ];
            cherryPickedCommitFgColor = [ "#a6e3a1" ];
            unstagedChangesColor = [ "#f38ba8" ];
            defaultFgColor = [ "#cdd6f4" ];
            searchingActiveBorderColor = [ "#f9e2af" ];
          };
          authorColors = {
            "*" = "#b4befe";
          };
          nerdFontsVersion = "3";
        };
      };
    };
  };
}
