{pkgs, ...}: {
  imports = [];

  programs.neovim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [
      sonokai

      nvim-lspconfig

      rustaceanvim

      plenary-nvim

      blink-cmp
      fzf-lua
      mini-icons
      mini-statusline

      gitsigns-nvim
      # (nvim-treesitter.withPlugins (_: pkgs.tree-sitter.allGrammars))
      vim-nix
    ];
    extraPackages = with pkgs; [
      fd
      git
      ripgrep

      cargo
      gofumpt
      gopls
      lua-language-server
      luajitPackages.lua-lsp
      nil
      ocamlPackages.ocaml-lsp
      rust-analyzer
    ];

    extraConfig = ''
      lua << EOF
      ${builtins.readFile ./neovim.lua}
      EOF
    '';
  };
}
