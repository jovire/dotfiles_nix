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
    ./ghostty/ghostty.nix
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

  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    alejandra # Opinionated nix formatter
    discord
    hack-font
    fd
    i3
    i3status-rust
    ripgrep
    rofi
  ];

  # disable warnings
  programs.neovim.withRuby = false;
  programs.neovim.withPython3 = false;

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

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
