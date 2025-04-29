##
# NordVpn Client through Wireguard
# TODO: replace this with a proper vpn module
##
{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    wgnord
  ];
}
