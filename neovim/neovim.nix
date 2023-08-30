{pkgs, ...}: {
  imports = [];

  programs.neovim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [
      catppuccin-nvim
      nvim-lspconfig
      telescope-nvim
      vim-nix
    ];
    extraPackages = with pkgs; [
      fd
      git
      ripgrep
    ];

    extraConfig = ''
      lua << EOF
      ${builtins.readFile ./neovim.lua}
      EOF
    '';
  };
}
