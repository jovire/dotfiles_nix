{
  lib,
  pkgs,
  ...
}: let
  mod = "Mod1";
in {
  xsession.windowManager.i3 = {
    enable = true;
    config = {
      modifier = mod;
      fonts = {
        names = ["Monego"];
      };
      keybindings = lib.mkOptionDefault {
        "${mod}+Return" = "exec ghostty";
        "${mod}+d" = "exec rofi -show drun";
      };
    };
  };
}
