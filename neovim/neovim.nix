{pkgs, ...}: {
  imports = [];

  programs.neovim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [
      catppuccin-nvim

      nvim-lspconfig
      nvim-cmp
      cmp-nvim-lua
      cmp-nvim-lsp
      cmp-path
      luasnip
      cmp_luasnip

      rustaceanvim

      telescope-nvim
      telescope-fzy-native-nvim
      telescope-file-browser-nvim
      plenary-nvim

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
