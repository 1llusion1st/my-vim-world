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


-- tmux navigator
g.tmux_navigator_no_mappings = 1
g.tmux_navigator_save_on_switch = 2

-- tagbar
g.tagbar_compact = 1
g.tagbar_sort = 0
