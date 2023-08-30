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
