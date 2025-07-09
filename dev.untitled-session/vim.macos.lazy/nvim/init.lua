vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

vim.opt.termguicolors = true
vim.g.mapleader = " " -- Make sure to set `mapleader` before lazy so your mappings are correct

require("lazy").setup({
  {import = "plugins"},
  {import = "plugins.lsp"},
})

require("settings")
require("cross")

vim.o.background = "dark" -- or "light" for light mode
vim.cmd([[colorscheme gruvbox]])

require("keymaps")

-- dev
require("own.luautils").setup({
  debug=false
})
require("own.markdown").setup({
})

local local_config = vim.fn.getcwd() .. '/.nvim.lua'
if vim.fn.filereadable(local_config) == 1 then
  vim.cmd('luafile ' .. local_config)
end

vim.cmd(":NvimTreeOpen<CR>")

