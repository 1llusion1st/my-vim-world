return {
  "folke/which-key.nvim",
  { "folke/neoconf.nvim", cmd = "Neoconf" },
  "folke/neodev.nvim",
  { 
    'javiorfo/nvim-soil',
    lazy = true,
    ft = "plantuml",
    config = function()
        -- If you want to change default configurations
    end
  },
  { 'javiorfo/nvim-nyctophilia' },
  {
    "iamcco/markdown-preview.nvim",
    ft = "markdown",
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
  },

  -- color schema
  { 'joshdick/onedark.vim' },
  { 'nvim-lualine/lualine.nvim',
    requires = {'kyazdani42/nvim-web-devicons', opt = true},
    config = function()
        require('lualine').setup()
    end, },
  {'akinsho/bufferline.nvim', requires = 'kyazdani42/nvim-web-devicons',
    config = function()
        require("bufferline").setup{}
    end, },

  -- filemanager
  { 'kyazdani42/nvim-tree.lua',
    requires = 'kyazdani42/nvim-web-devicons',
    config = function() require'nvim-tree'.setup {} end, },
  { 'majutsushi/tagbar'},
  { 'preservim/nerdtree'},
  { 'christoomey/vim-tmux-navigator' },
  { 'majutsushi/tagbar' },
  { 'junegunn/fzf',
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
  },
  { 'junegunn/fzf.vim'},

  -- themes
  { 'Dave-Elec/gruvbox', priority = 1000 },
  { 'danilo-augusto/vim-afterglow'},
}
