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
      fonts = ["Mongeo"];
      keybindings = lib.mkOptionDefault {
        "${mod}+Return" = "exec wezterm";
      };
    };
  };
}
