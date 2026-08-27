-- --------
-- Settings
-- --------
vim.opt.autoindent = true
vim.opt.belloff = "all"
vim.o.colorcolumn = '100'
vim.opt.cursorline = false
vim.opt.cmdheight = 1
vim.opt.expandtab = true
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.laststatus = 3
vim.opt.mouse = "a"
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.showcmd = true
vim.opt.showmode = false
vim.opt.smartcase = true
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.swapfile = false

-- Completion Menu
vim.opt.pumblend = 0
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
vim.keymap.set("n", "<leader>p", "\"*p")
vim.keymap.set("v", "<leader>p", "\"*p")

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
vim.opt.termguicolors = false
vim.cmd.colorscheme("sonokai")

-- -------
-- Plugins
-- -------

-- Completions
require('blink.cmp').setup({
  completion = {
    documentation = { auto_show = true },
    menu = {
      draw = {
        columns = {
          { 'label', 'label_description', gap = 1 },
          -- {'kind_icon', 'kind', gap = 1 }
          {'kind', gap = 1 }
        },
      },
    },
  },
  keymap = { preset = 'default' },
  appearance = {
    nerd_font_variant = 'mono'
  },
  fuzzy = {
    sorts = { 'exact', 'score', 'sort_text' },
    implementation = 'prefer_rust_with_warning',
  },
  sources = {
    min_keyword_length = 3,
  },
})

-- LSP
local capabilities = vim.tbl_deep_extend(
  "force",
  vim.lsp.protocol.make_client_capabilities(),
  {
    workspace = {
      didChangeWatchedFiles = {
	dynamicRegistration = true
      }
    },
  }
)

vim.api.nvim_create_autocmd("LspAttach", {
  group = augroup, --not sure what this does
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if client then
      client.server_capabilities.semanticTokensProvider = nil
    end
    local bufopts = { noremap = true, silent = true, buffer = ev.buf }
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, bufopts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'gT', vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set('n', '<leader>cr', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, bufopts)
    vim.keymap.set('n', ']d', vim.diagnostic.goto_prev, bufopts)

    vim.cmd.autocmd('BufWritePre <buffer> lua vim.lsp.buf.format()')
    vim.keymap.set('n', 'gr', [[<cmd>FzfLua lsp_references<CR>]], bufopts)
    vim.keymap.set('n', 'gi', [[<cmd>FzfLua lsp_implementations<CR>]], bufopts)
    vim.keymap.set('n', '<leader>K', [[<cmd>split <bar> FzfLua lsp_definitions<CR>]], bufopts)
  end
})

vim.g.rustaceanvim = function()
  return {
    server = {
      default_settings = {
        ['rust-analyzer'] = {
          cargo = {
            allFeatures = true,
            loadOutDirsFromCheck = true,
            runBuildScripts = true,
          },
          inlayHints = {
            lifetimeElisonHints = {
              enable = true,
              useParameterNames = true,
            },
          },
        },
      },
    },
  }
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

-- Fzf-lua
local key_map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

key_map('n', '<space>en', [[<cmd>lua require('fzf-lua').files({cwd = "~/.config/nvim"})<CR>]], opts)
key_map('n', '<space>cs', [[<cmd>FzfLua colorschemes<CR>]], opts)

key_map('n', '<space>fd', [[<cmd>FzfLua files<CR>]], opts)
key_map('n', '<space>fg', [[<cmd>FzfLua live_grep<CR>]], opts)

-- mini.statusline
local H = {}

require('mini.statusline').setup({
  use_icons = true,
  content = {
    inactive = function()
      local pathname = H.section_pathname({ trunc_width = 120 })
      return MiniStatusline.combine_groups({
        { hl = 'MiniStatuslineInactive', strings = { pathname } },
      })
    end,
    active = function()
      -- stylua: ignore start
      local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 120 })
      local git           = MiniStatusline.section_git({ trunc_width = 40 })
      local diff          = MiniStatusline.section_diff({ trunc_width = 60 })
      local diagnostics   = MiniStatusline.section_diagnostics({ trunc_width = 60 })
      local lsp           = MiniStatusline.section_lsp({ trunc_width = 40 })
      local filetype      = H.section_filetype({ trunc_width = 70 })
      local location      = H.section_location({ trunc_width = 120 })
      local search        = H.section_searchcount({ trunc_width = 80 })
      local pathname      = H.section_pathname({
        trunc_width = 100,
        filename_hl = "MiniStatuslineFilename",
        modified_hl = "MiniStatuslineFilenameModified" })

      -- Usage of `MiniStatusline.combine_groups()` ensures highlighting and
      -- correct padding with spaces between groups (accounts for 'missing'
      -- sections, etc.)
      return MiniStatusline.combine_groups({
        { hl = mode_hl,                   strings = { mode:upper() } },
        { hl = 'MiniStatuslineDevinfo',   strings = { git, diff } },
        '%<', -- Mark general truncate point
        { hl = 'MiniStatuslineDirectory', strings = { pathname } },
        '%=', -- End left alignment
        { hl = 'MiniStatuslineFileinfo',  strings = { filetype, diagnostics, lsp } },
        { hl = mode_hl,                   strings = { search .. location } },
      })
      -- stylua: ignore end
    end,
  },
})

-- Utility from mini.statusline
H.isnt_normal_buffer = function() return vim.bo.buftype ~= '' end

H.has_no_lsp_attached = function() return #vim.lsp.get_clients() == 0 end

H.get_filetype_icon = function()
  -- Have this `require()` here to not depend on plugin initialization order
  local has_devicons, devicons = pcall(require, 'nvim-web-devicons')
  if not has_devicons then return '' end

  local file_name, file_ext = vim.fn.expand('%:t'), vim.fn.expand('%:e')
  return devicons.get_icon(file_name, file_ext, { default = true })
end

H.section_location = function(args)
  -- Use virtual column number to allow update when past last column
  if MiniStatusline.is_truncated(args.trunc_width) then return '%-2l│%-2v' end

  return '󰉸 %-2l│󱥖 %-2v'
end

H.section_filetype = function(args)
  if MiniStatusline.is_truncated(args.trunc_width) then return '' end

  local filetype = vim.bo.filetype
  if (filetype == '') or H.isnt_normal_buffer() then return '' end

  local icon = H.get_filetype_icon()
  if icon ~= '' then filetype = string.format('%s %s', icon, filetype) end

  return filetype
end

--- Section for current search count
---
--- Show the current status of |searchcount()|. Empty output is returned if
--- window width is lower than `args.trunc_width`, search highlighting is not
--- on (see |v:hlsearch|), or if number of search result is 0.
---
--- `args.options` is forwarded to |searchcount()|. By default it recomputes
--- data on every call which can be computationally expensive (although still
--- usually on 0.1 ms order of magnitude). To prevent this, supply
--- `args.options = { recompute = false }`.
H.section_searchcount = function(args)
  if vim.v.hlsearch == 0 then return '' end
  -- `searchcount()` can return errors because it is evaluated very often in
  -- statusline. For example, when typing `/` followed by `\(`, it gives E54.
  local ok, s_count = pcall(vim.fn.searchcount, (args or {}).options or { recompute = true })
  if not ok or s_count.current == nil or s_count.total == 0 then return '' end

  local icon = MiniStatusline.is_truncated(args.trunc_width) and '' or ' '
  if s_count.incomplete == 1 then return icon .. '?/?│' end

  local too_many = ('>%d'):format(s_count.maxcount)
  local current = s_count.current > s_count.maxcount and too_many or s_count.current
  local total = s_count.total > s_count.maxcount and too_many or s_count.total
  return ('%s%s/%s│'):format(icon, current, total)
end

H.section_pathname = function(args)
  args = vim.tbl_extend('force', {
    modified_hl = nil,
    filename_hl = nil,
    trunc_width = 80,
  }, args or {})

  if vim.bo.buftype == 'terminal' then return '%t' end

  local path = vim.fn.expand('%:p')
  local cwd = vim.uv.cwd() or ''
  cwd = vim.uv.fs_realpath(cwd) or ''

  if path:find(cwd, 1, true) == 1 then path = path:sub(#cwd + 2) end

  local sep = package.config:sub(1, 1)
  local parts = vim.split(path, sep)
  if require('mini.statusline').is_truncated(args.trunc_width) and #parts > 3 then
    parts = { parts[1], '…', parts[#parts - 1], parts[#parts] }
  end

  local dir = ''
  if #parts > 1 then dir = table.concat({ unpack(parts, 1, #parts - 1) }, sep) .. sep end

  local file = parts[#parts]
  local file_hl = ''
  if vim.bo.modified and args.modified_hl then
    file_hl = '%#' .. args.modified_hl .. '#'
  elseif args.filename_hl then
    file_hl = '%#' .. args.filename_hl .. '#'
  end
  local modified = vim.bo.modified and ' [+]' or ''
  return dir .. file_hl .. file .. modified
end
