##
# configure direnv for the user to enable seemless developer shells
##
{ ... }:
{
  programs = {
    direnv = {
      enable = true;
      # enableFishIntegration = true;
      nix-direnv.enable = true;
    };
  };
}
