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
      -- text = "#FFFFFF",
      -- base = "#000000",
      base = "#202020",
      mantle = "#202020",
      crust = "#202020",
    },
  },
  -- higlight_overrides = {
    custom_highlights = function(colors)
      local darkening_percentage = 0.095
      local U = require('catppuccin.utils.colors')
      return {
        -- TabLineSel = { bg = colors.pink },
        -- CmpBorder = { fg = colors.surface2 },
        -- GitSignsChange = { fg = colors.blue },
        TelescopeResultsTitle = { bg = colors.green, fg = colors.base },
        TelescopePromptTitle = { bg = colors.yellow, fg = colors.base },
        TelescopePreviewTitle = { bg = colors.red, fg = colors.base },
        TermCursor = { link = 'Cursor' },
        TermCursorNC = { bg = colors.red, fg = colors.text, ctermbg = 1, ctermfg = 15 },
        LspCodeLens = { fg = colors.mauve, bg = U.darken(colors.mauve, darkening_percentage, colors.base), italic = true },
        FidgetTitle = { link = 'DiagnosticHint' },
        FloatBorder = { fg = colors.base, bg = colors.base },
        DiagnosticFloatingError = { bg = U.darken(colors.red, darkening_percentage, colors.base) },
        DiagnosticFloatingWarn = { bg = U.darken(colors.yellow, darkening_percentage, colors.base) },
        DiagnosticFloatingHint = { bg = U.darken(colors.green, darkening_percentage, colors.base) },
        DiagnosticFloatingOk = { bg = U.darken(colors.green, darkening_percentage, colors.base) },
      }
    end,
  -- },
})
vim.cmd.colorscheme("catppuccin")


-- -------
-- Plugins
-- -------

-- LSP
-- local capabilities = require("cmp_nvim_lsp").default_capabilities()
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

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

vim.lsp.config('gopls', {
  cmd = { 'gopls' },
  filetypes = { 'go', 'gomod', 'gowork', 'gotmpl' },
  root_markers = { 'go.mod', 'go.work', '.git' },
  capabilities = capabilities,
})

vim.lsp.config('lua_ls', {
  cmd = { 'lua-lanaguage-server' },
  filetypes = { 'lua' },
  root_markers = { '.luarc.json', '.luarc.jsonc', '.stylua.toml', 'stylua.toml', '.git' },
  capabilities = capabilities,
  settings = {
    Lua = {
      completion = {
        callSnippet = 'Replace',
      },
      diagnostics = {
        globals = {
          'vim'
        },
      },
      format = {
        enable = false,
      },
    },
  },
})

vim.lsp.config('ocamllsp', {})

-- Telescope
require("telescope").setup{}
require("telescope").load_extension("file_browser")
require("telescope").load_extension("fzy_native")

local builtin = require("telescope.builtin")
vim.keymap.set("n", "<space>fd", builtin.find_files, {})
vim.keymap.set("n", "<space>fg", ":Telescope git_files<CR>", {})
vim.keymap.set("n", "<space>fe", ":Telescope file_browser<CR>", {})
