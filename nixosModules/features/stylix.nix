# Enable stylix system wide
# user configuration should be done in home manager
{ inputs, ... }:
let
  inherit (inputs) tinted-schemes;
in
{
  imports = [
    inputs.stylix.nixosModules.stylix
  ];

  stylix = {
    enable = true;
    image = ../../resources/images/wallpaper-neon-city.jpg;
    base16Scheme = "${tinted-schemes}/base16/spaceduck.yaml";

    # remove due to error with fonts as part of latest update
    targets.kmscon.enable = false;
  };
}
