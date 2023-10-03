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
  { 'preservim/nerdtree',
    dependencies = {
      'Xuyuanp/nerdtree-git-plugin',
      'ryanoasis/vim-devicons'}
  },
  { 'christoomey/vim-tmux-navigator' },
  { 'majutsushi/tagbar' },
  { 'junegunn/fzf',
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
  },
  { 'junegunn/fzf.vim'},
  { 'nvim-treesitter/nvim-treesitter' },
  { 'neovim/nvim-lspconfig' },
  { 'williamboman/nvim-lsp-installer' },

  -- lsp autocomplete
  { 'hrsh7th/nvim-cmp' },
  { 'hrsh7th/cmp-nvim-lsp' },
  { 'hrsh7th/cmp-buffer' },
  { 'saadparwaiz1/cmp_luasnip' },

  -- fs autocomplete
  { 'hrsh7th/cmp-path' },

  -- git
  { 'tpope/vim-fugitive' },
  { 'airblade/vim-gitgutter' },

  -- notifications
  { 'rcarriga/nvim-notify' },

  -- snippets
  { 'L3MON4D3/LuaSnip' },

  -- telescope
  {
    'nvim-telescope/telescope.nvim', tag = '0.1.3',
-- or                              , branch = '0.1.x',
      dependencies = {
        'nvim-lua/plenary.nvim',
        { 'nvim-telescope/telescope-fzf-native.nvim', build = "make" },
        "nvim-tree/nvim-web-devicons",
      },
      config = function()
        local telescope = require("telescope")
        local actions = require("telescope.actions")
        telescope.setup({
          defaults = {
            mappings = {
              i = {
                ["C-k"] = actions.move_selection_previous,
                ["C-j"] = actions.move_selection_next,
                ["C-q"] = actions.send_selected_to_qflist + actions.open_qflist,
              }
            }}
        })
        telescope.load_extension("fzf")

        local km = vim.keymap
        local s = km.set
        s("n", "<space>fo", "<cmd>Telescope oldfiles<CR>", { desc = "fuzzy recent files find" })
        s("n", "<space>ff", "<cmd>Telescope find_files<CR>", { desc = "fuzzy files find" })
      end
  },

  -- themes
  { 'Dave-Elec/gruvbox', priority = 1000 },
  { 'danilo-augusto/vim-afterglow'},

  { 'stevearc/dressing.nvim',
    event = "VeryLazy",
  },
}
