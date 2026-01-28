{
  config,
  inputs,
  pkgs,
  ...
}: let
in {
  home = {
    username = "jovire";
    homeDirectory = "/home/jovire";
    stateVersion = "24.05";
    sessionVariables = {
      EDITOR = "nvim";
    };
  };
  imports = [
    ./neovim/neovim.nix
    ./i3.nix
  ];

  nixpkgs = {
    overlays = [
    ];
    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };
  };

  home.packages = with pkgs; [
    alejandra # Opinionated nix formatter
    discord
    i3
    i3status-rust
    rofi
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.wezterm = {
    enable = true;
    package = config.lib.nixGL.wrap pkgs.wezterm;
  };

  # Cannot set default shell through home-manager
  programs.fish.enable = true;

  programs.git = {
    enable = true;
    settings = {
      user.name = "Joshua Remington";
      user.email = "jremington1230@gmail.com";
      init.defaultBranch = "main";
    };
  };
  programs.btop.enable = true;
  programs.i3status-rust.enable = true;

  programs.ghostty = {
    enable = true;
    package = config.lib.nixGL.wrap pkgs.ghostty;
  };

  # Nicely reload system unites when changing configs
  systemd.user.startServices = "sd-switch";
  targets.genericLinux = {
    enable = true;
    nixGL = {
      packages = inputs.nixGL.packages;
      installScripts = ["mesa"];
    };
  };
}
