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
  ];

  home.packages = with pkgs; [
    # Opinionated nix formatter
    alejandra
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
  programs.htop.enable = true;

  fonts.fontconfig.enable = true;
  systemd.user.startServices = "sd-switch";
  targets.genericLinux.enable = true;
}
