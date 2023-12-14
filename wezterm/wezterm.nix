{
  pkgs,
  config,
  ...
}: {
  imports = [];

  programs.wezterm = {
    enable = true;
    colorSchemes.mcroughan = {
      background = "#000000";
      foreground = "#E9E9E9";
      selection_bg = "#424242";
      selection_fg = "#000000";
      ansi = ["#000000" "#D44D53" "#B9C949" "#E6C446" "#79A6DA" "#C396D7" "#70C0B1" "#FFFEFE"];
      brights = ["#000000" "#D44D53" "#B9C949" "#E6C446" "#79A6DA" "#C396D7" "#70C0B1" "#FFFEFE"];
    };
    colorSchemes.helios = {
      background = "#1D2021";
      foreground = "#E5E5E5";
      ansi = ["#1D2021" "#383C3E" "#53585B" "#6F7579" "#CDCDCD" "#D5D5D5" "#DDDDDD" "#E5E5E5"];
      brights = ["#D72638" "#EB8413" "#F19D1A" "#88B92D" "#1BA595" "#1E8BAC" "#BE4264" "#C85E0D"];
    };
    extraConfig = ''
      local w = require('wezterm')
      local cfg = w.config_builder()

      cfg.color_scheme = 'mcroughan'
      cfg.font = w.font("Monego Ligatures")
      cfg.font_size = 14
      cfg.use_fancy_tab_bar = false
      cfg.tab_bar_at_bottom = true
      cfg.hide_tab_bar_if_only_one_tab = true

      return cfg
    '';
  };
}
