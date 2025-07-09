local map = vim.api.nvim_set_keymap
local default_opts = {noremap = true, silent = true}

-- emulate ESC on fast jj keypress
map('i', 'jj', '<Esc>', {noremap = true})

-- disable arrows
map('', '<up>', ':echoe "Use k"<CR>', {noremap = true, silent = false})
map('', '<down>', ':echoe "Use j"<CR>', {noremap = true, silent = false})
map('', '<left>', ':echoe "Use h"<CR>', {noremap = true, silent = false})
map('', '<right>', ':echoe "Use l"<CR>', {noremap = true, silent = false})

-- base navigation
map('n', '<Space>', '<PageDown> zz', default_opts)
map('n', '<S-Space>', '<PageUp> zz', default_opts)

-- buffers
map('', '<space>b', ':bp<CR>', default_opts)
map('', '<space>p', ':bnext<CR>', default_opts)
-- map('', '<space>B', ':lua require("buffer_manager.ui").toggle_quick_menu()<CR>', default_opts)
map('', '<space>B', ':lua Telescope buffers<CR>', default_opts)

-- tabs
map('', '<space>R', ':tabp<CR>', default_opts)
map('', '<space>N', ':tabn<CR>', default_opts)

-- nerdtree/nvimtree
-- map('', '<space>t', ':<C-U>NERDTree<CR>', default_opts)
map('', '<space>t', ':<C-U>NvimTreeOpen<CR>', default_opts)
map('', '<space>tt', ':<C-U>NvimTreeFindFile<CR>', default_opts)

-- tmux navigation
map('', '{Left-Mapping}', ':<C-U>TmuxNavigateLeft<CR>', default_opts)
map('', '{Down-Mapping}', ':<C-U>TmuxNavigateDown<CR>', default_opts)

map('', '{Up-Mapping} ', ':<C-U>TmuxNavigateUp<CR>', default_opts)
map('', '{Right-Mapping}', ':<C-U>TmuxNavigateRight<CR>', default_opts)
map('', '{Previous-Mapping}', ':<C-U>TmuxNavigatePrevious<CR>', default_opts)

map('', '<C-h>', ':<C-U>TmuxNavigateLeft<CR>', default_opts)
map('', '<C-l>', ':<C-U>TmuxNavigateRight<CR>', default_opts)
map('', '<C-j>', ':<C-U>TmuxNavigateDown<CR>', default_opts)
map('', '<C-k>', ':<C-U>TmuxNavigateUp<CR>', default_opts)

-- tagbar
map('', '<space>T', ':<C-U>TagbarToggle<CR>', default_opts)

-- fzf
map('n', '<space>f', ':<C-U>FZF<CR>', default_opts)

-- go
map('', '<space>L', ':<C-U>GoLint<CR>', default_opts)

