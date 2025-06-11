# apply overlays for the config
{ inputs, ... }:
{
  nixpkgs.overlays = [
    inputs.ballsvim.overlays.default
  ];
}
