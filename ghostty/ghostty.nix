{
  pkgs,
  config,
  ...
}: {
  imports = [];
  programs.ghostty = {
    enable = true;
    package = config.lib.nixGL.wrap pkgs.ghostty;
    enableFishIntegration = true;
  };
}
