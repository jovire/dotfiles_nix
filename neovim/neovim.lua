-- --------
-- Settings
-- --------
vim.opt.autoindent = true
vim.opt.belloff = "all"
vim.opt.cursorline = false
vim.opt.cmdheight = 1
vim.opt.expandtab = true
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.laststatus = 3
vim.opt.mouse = "n"
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.showcmd = true
vim.opt.showmode = true
vim.opt.smartcase = true
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.swapfile = false

-- Completion Menu
vim.opt.pumblend = 17
vim.opt.wildmode = "longest:full"
vim.opt.wildoptions = "pum"

-- Indents/Tabs/Spaces
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2

-- --------
-- Mappings
-- --------
vim.g.mapleader = ","

-- Copy to system clipboard
vim.keymap.set("n", "<leader>y", "\"*y")
vim.keymap.set("v", "<leader>y", "\"*y")

-- Pane navigation
vim.keymap.set("n", "<C-h>", "<C-W><C-h>")
vim.keymap.set("n", "<C-j>", "<C-W><C-j>")
vim.keymap.set("n", "<C-k>", "<C-W><C-k>")
vim.keymap.set("n", "<C-l>", "<C-W><C-l>")

-- Terminal Pane Navigation
vim.keymap.set("t", "<C-h>", "<C-\\><C-N><C-w>h", {silent = true})
vim.keymap.set("t", "<C-j>", "<C-\\><C-N><C-w>j", {silent = true})
vim.keymap.set("t", "<C-k>", "<C-\\><C-N><C-w>k", {silent = true})
vim.keymap.set("t", "<C-l>", "<C-\\><C-N><C-w>l", {silent = true})

-- Center Screen
vim.keymap.set("n", "<space>", "zz")

-- Search mappings
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Same when going up/down
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Move sanely through wrapped lines
vim.keymap.set("n", "j", "gj")
vim.keymap.set("n", "k", "gk")

-- Get rid of q: window
vim.keymap.set("", "q:", ":q")

-- Colorscheme
require("catppuccin").setup({
  flavour = "mocha",
  term_colors = true,
  color_overrides = {
    mocha = {
      text = "#FFFFFF",
      base = "#000000",
    },
  },
  higlight_overrides = {
    mocha = function(mocha)
      return {
        TabLineSel = { bg = mocha.pink },
        CmpBorder = { fg = mocha.surface2 },
        GitSignsChange = { fg = mocha.blue },
      }
    end,
  },
})
vim.cmd.colorscheme("catppuccin")


-- -------
-- Plugins
-- -------

-- LSP
local capabilities = require("cmp_nvim_lsp").default_capabilities()

local on_attach = function(client, bufnr)
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
  vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, bufopts)
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
  vim.keymap.set("n", "gT", vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, bufopts)
  vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, bufopts)
  vim.keymap.set("i", "<C-s>", vim.lsp.buf.signature_help, bufopts)

  vim.cmd.autocmd("BufWritePro <buffer> lua vim.lsp.buf.format()")
end

require"lspconfig".gopls.setup{
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    gopls = {
      gofumpt = true,
      completeUnimported = true,
    }
  }
}

require"lspconfig".ocamllsp.setup{
  capabilities = capabilities,
  on_attach = on_attach,
}

require"lspconfig".rust_analyzer.setup{
  capabilities = capabilities,
  on_attach = on_attach,
  cmd = {"rustup", "run", "stable", "rust-analyzer"}
}

require"lspconfig".lua_ls.setup{
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    Lua = {
      diagnostics = {
        globals = {
          "vim"
        },
      },
      format = {
        enable = false,
      },
    },
  },
}

-- Telescope
require("telescope").setup{}
require("telescope").load_extension("file_browser")
require("telescope").load_extension("fzy_native")

local builtin = require("telescope.builtin")
vim.keymap.set("n", "<space>fd", builtin.find_files, {})
vim.keymap.set("n", "<space>fg", ":Telescope git_files<CR>", {})
vim.keymap.set("n", "<space>fe", ":Telescope file_browser<CR>", {})
