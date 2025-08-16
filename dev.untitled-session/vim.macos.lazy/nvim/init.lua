vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- for MacOS using brew
-- brew install luajit
-- luarocks --lua-dir="$(brew --prefix luajit)" install luasocket
-- luarocks --lua-dir="$(brew --prefix luajit)" install lua-cjson

local home = os.getenv("HOME")
package.path  = (package.path or "") .. ";" ..
  home .. "/.luarocks/share/lua/5.1/?.lua;" ..
  home .. "/.luarocks/share/lua/5.1/?/init.lua"
package.cpath = (package.cpath or "") .. ";" ..
  home .. "/.luarocks/lib/lua/5.1/?.so"


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

