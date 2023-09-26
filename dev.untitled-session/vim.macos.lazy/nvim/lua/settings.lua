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

-- tmux navigator
g.tmux_navigator_no_mappings = 1
g.tmux_navigator_save_on_switch = 2

-- tagbar
g.tagbar_compact = 1
g.tagbar_sort = 0
