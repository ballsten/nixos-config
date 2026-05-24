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
    };
  };
}
