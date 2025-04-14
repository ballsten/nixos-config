###############################################################################
#
#  WSL system configuration
#
#  Majority of configuration should be parametised and handled by the 
#  system module.
#
###############################################################################

{
  # import WSL module
  modules = {
    system = {
      username = "ballsten";
      hashedPassword = "$y$j9T$pzQ45Xjuzy6kVT2wLfpK41$a6CozSBdXG.qJeFfn9TZUB0lIFCDi3XMJtxbLFXb3M8";
      hostName = "wsl";
      variant= "wsl";
    };
    # desktop = {
    #   enabled = false;
    # };
  };
}
