{ lib, config, inputs, ... }:
{
  imports = [
    inputs.nixos-wsl.nixosModules.wsl
  ];

  config = lib.mkIf (config.modules.system.variant == "wsl") {
    wsl = {
      enable = true;
      defaultUser = config.modules.system.username;
    };
  };
}
