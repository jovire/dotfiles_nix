{
  config,
  pkgs,
  ...
}: {
  home = {
    username = "jovire";
    homeDirectory = "/home/jovire";
    stateVersion = "23.05";
    sessionVariables = {
      EDITOR = "nvim";
    };
  };
  imports = [
    ./neovim/neovim.nix
    ./wezterm/wezterm.nix
    ./i3.nix
    ./rofi.nix
  ];

  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };
  };

  xdg.enable = true;
  xdg.desktopEntries = {
    wezterm = {
      name = "Wezterm";
      exec = "nixGL wezterm";
      terminal = true;
    };
  };

  home.packages = with pkgs; [
    # Opinionated nix formatter
    alejandra
    discord
    i3
    i3status-rust
    rofi
  ];
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Cannot set default shell through home-manager
  programs.fish.enable = true;

  programs.git = {
    enable = true;
    userName = "Joshua Remington";
    userEmail = "jremington1230@gmail.com";
    extraConfig = {
      init.defaultBranch = "main";
      core.editor = "nvim";
      url = {
        "git@github.com:" = {insteadOf = "https://github.com/";};
      };
    };
  };
  programs.btop.enable = true;
  programs.i3status-rust.enable = true;

  systemd.user.startServices = "sd-switch";
  targets.genericLinux.enable = true;
}
