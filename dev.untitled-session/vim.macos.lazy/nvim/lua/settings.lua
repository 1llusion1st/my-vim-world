local cmd = vim.cmd             -- execute Vim commands
local exec = vim.api.nvim_exec  -- execute Vimscript
local g = vim.g                 -- global variables
local opt = vim.opt             -- global/buffer/windows-scoped options

cmd([[
filetype indent plugin on
syntax enable
set noswapfile
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

vim.keymap.set("n", "FF", ":NvimTreeFindFile<CR>", {})

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
-- [[
-- docker run -d -p 8080:8080 plantuml/plantuml-server:jetty
-- docker run --restart=unless-stopped --name plantuml-server-jetty -d -p 9901:8080 plantuml/plantuml-server:jetty

-- ]] --
g.mkdp_preview_options = {
  uml = {
    server =  'http://localhost:9901',
    imageFormat = "svg",
    diagramName = "uml",
  }
}

cmd [[
autocmd FileType NvimTree,tagbar autocmd BufEnter,TextChanged,InsertLeave <buffer> set nu
]]

vim.cmd(":NvimTreeOpen<CR>")

vim.keymap.set("n", "<space>tm", ":Telescope make<CR>", {})
vim.keymap.set("n", "<space>tT", ":Telescope telescope-tabs list_tabs<CR>", {})
vim.keymap.set("n", "<space>tb", ":Telescope buffers<CR>", {})
vim.keymap.set("n", "<space>tG", ":Telescope grep_string<CR>", {})
vim.keymap.set("n", "<space>F", "<cmd>Telescope find_files<CR>", { desc = "fuzzy files find" })
vim.keymap.set("n", "<space>tm", ":Telescope make<CR>", {})
vim.keymap.set("n", "<space>td", ":Telescope diagnostics<CR>", {})

vim.keymap.set('v', '<space>C', ":'<,'>CommentToggle<CR>", {})

-- <C-\><C-n>
vim.keymap.set('t', 'jj', '<C-\\><C-N>', {})

-- markdown

-- camel case
function switch_case()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  local word = vim.fn.expand('<cword>')
  local word_start = vim.fn.matchstrpos(vim.fn.getline('.'), '\\k*\\%' .. (col+1) .. 'c\\k*')[2]

  -- Detect camelCase
  if word:find('[a-z][A-Z]') then
    -- Convert camelCase to snake_case
    local snake_case_word = word:gsub('([a-z])([A-Z])', '%1_%2'):lower()
    vim.api.nvim_buf_set_text(0, line - 1, word_start, line - 1, word_start + #word, {snake_case_word})
  -- Detect snake_case
  elseif word:find('_[a-z]') then
    -- Convert snake_case to camelCase
    local camel_case_word = word:gsub('(_)([a-z])', function(_, l) return l:upper() end)
    vim.api.nvim_buf_set_text(0, line - 1, word_start, line - 1, word_start + #word, {camel_case_word})
  else
    print("Not a snake_case or camelCase word")
  end
end

vim.api.nvim_set_keymap('n', '<Leader>s', '<cmd>lua switch_case()<CR>', {noremap = true, silent = true})
