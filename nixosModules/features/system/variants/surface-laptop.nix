{ lib, config, inputs, ... }:
{
  imports = [
  ];

  config = lib.mkIf (config.modules.system.variant == "surface-intel") {
    wsl = {
      enable = true;
      defaultUser = config.modules.system.username;
    };
  };
}
