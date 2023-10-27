local cmd = vim.cmd             -- execute Vim commands
local exec = vim.api.nvim_exec  -- execute Vimscript
local g = vim.g                 -- global variables
local opt = vim.opt             -- global/buffer/windows-scoped options

cmd([[
filetype indent plugin on
syntax enable
]])

opt.number = true
opt.foldcolumn = '2'

-- main
opt.colorcolumn = '80'
opt.cursorline = true
opt.so=999
opt.cc='80'
opt.cursorline = true
opt.undofile = true
opt.splitright = true
opt.splitbelow = true
opt.clipboard='unnamedplus' -- bind clipboard to OS

-- indents
opt.expandtab = true      -- use spaces instead of tabs
opt.shiftwidth = 4        -- shift 4 spaces when tab
opt.tabstop = 4           -- 1 tab == 4 spaces
opt.smartindent = true    -- autoindent new lines

-- don't auto commenting new lines
cmd [[au BufEnter * set fo-=c fo-=r fo-=o]]
-- remove line lenght marker for selected filetypes
cmd [[autocmd FileType text,markdown,html,xhtml,javascript setlocal cc=0]]
-- 2 spaces for selected filetypes
cmd [[
autocmd FileType xml,html,xhtml,css,scss,javascript,lua,yaml,htmljinja setlocal shiftwidth=2 tabstop=2
]]

-- colors
opt.termguicolors = true

-- netrw
g.loaded_netrw = 1
g.loaded_netrwPlugin = 1

-- nvim-tree

-- pass to setup along with your other options
local my_nvim_settings = require("nvim_tree")
require("nvim-tree").setup {
  ---
  on_attach = my_nvim_settings.my_on_attach,
  ---
}

-- dadbod
local autocomplete_group = vim.api.nvim_create_augroup("vimrc_autocompletion", { clear = true })
local cmp = require("cmp")
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "sql", "mysql", "plsql" },
  callback = function()
    cmp.setup.buffer({
      sources = {
        { name = "vim-dadbod-completion" },
        { name = "buffer" },
        { name = "luasnip" },
      },
    })
  end,
  group = autocomplete_group,
})

require("cmp") -- must have this

-- treejs
local tsj = require('treesj')

local langs = {--[[ configuration for languages ]]}

tsj.setup({
  ---@type boolean Use default keymaps (<space>m - toggle, <space>j - join, <space>s - split)
  use_default_keymaps = true,
  ---@type boolean Node with syntax error will not be formatted
  check_syntax_error = true,
  ---If line after join will be longer than max value,
  ---@type number If line after join will be longer than max value, node will not be formatted
  max_join_length = 120,
  ---Cursor behavior:
  ---hold - cursor follows the node/place on which it was called
  ---start - cursor jumps to the first symbol of the node being formatted
  ---end - cursor jumps to the last symbol of the node being formatted
  ---@type 'hold'|'start'|'end'
  cursor_behavior = 'hold',
  ---@type boolean Notify about possible problems or not
  notify = true,
  ---@type boolean Use `dot` for repeat action
  dot_repeat = true,
  ---@type nil|function Callback for treesj error handler. func (err_text, level, ...other_text)
  on_error = nil,
  ---@type table Presets for languages
  -- langs = {}, -- See the default presets in lua/treesj/langs
})

-- Run gofmt + goimport on save

local format_sync_grp = vim.api.nvim_create_augroup("GoImport", {})
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.go",
  callback = function()
   require('go.format').goimport()
  end,
  group = format_sync_grp,
})

-- tmux navigator
g.tmux_navigator_no_mappings = 1
g.tmux_navigator_save_on_switch = 2

-- tagbar
g.tagbar_compact = 1
g.tagbar_sort = 0

-- open links in browser
vim.keymap.set( "n", "gx", ":execute '!open ' . shellescape(expand('<cfile>'), 1)<CR>", {})

-- lsp_lines

vim.keymap.set( "n", "<space>l", ":lua require('lsp_lines').toggle()<CR>", {})

-- go implement
vim.keymap.set('n', '<space>M', [[<cmd>lua require'telescope'.extensions.goimpl.goimpl{}<CR>]], {noremap=true, silent=true})


-- treesj
require('treesj').setup({
  max_join_length = 1024,
})
vim.keymap.set( "n", "tj", ":TSJToggle<CR>", {})
vim.keymap.set( "n", "tJ", ":lua require('treesj').toggle({ split = { recursive = true } })<CR>", {})


-- MarkdownPreview PlantUML config
-- https://github.com/iamcco/markdown-preview.nvim/blob/master/app/pages/plantuml.js
g.mkdp_preview_options = {
  uml = {
    server =  'http://localhost:9901',
    imageFormat = "svg",
    diagramName = "uml",
  }
}
vim.cmd(":NvimTreeOpen<CR>")

