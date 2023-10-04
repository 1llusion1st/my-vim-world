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
  { 'hrsh7th/nvim-cmp',
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-buffer", -- source for text in buffer
      "hrsh7th/cmp-path", -- source for file system paths
      "L3MON4D3/LuaSnip", -- snippet engine
      "saadparwaiz1/cmp_luasnip", -- for autocompletion
      "rafamadriz/friendly-snippets", -- useful snippets
      "onsails/lspkind.nvim", -- vs-code like pictograms
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      local lspkind = require("lspkind")

      require("luasnip.loaders.from_vscode").lazy_load()
      cmp.setup({
        completion = {
          -- completeopt = "menu,menuone,preview,noselect",
          completeopt = "menu,menuone,preview",
        },
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-k>"] = cmp.mapping.select_prev_item(), -- previous suggestion
          ["<C-j>"] = cmp.mapping.select_next_item(), -- next suggestion
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(), -- show completion suggestions
          ["<C-e>"] = cmp.mapping.abort(), -- close completion window
          ["<CR>"] = cmp.mapping.confirm({ select = false }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" }, -- snippets
          { name = "buffer" }, -- text within current buffer
          { name = "path" }, -- file system paths
        }),
        formatting = {
          format = lspkind.cmp_format({
            maxwidth = 50,
            ellipsis_char = "...",
          }),
        },
      })
    end
  },
  -- { 'hrsh7th/cmp-nvim-lsp' },

  -- git
  { 'tpope/vim-fugitive' },
  { 'airblade/vim-gitgutter' },

  -- notifications
  { 'rcarriga/nvim-notify' },

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

  -- special language libraries
  -- go
  { 'fatih/vim-go',
    config = function()
        vim.keymap.set("n", "<space>F", "<cmd>GoFillStruct<CR>", { desc = "fill current struct" })
    end
  },

  -- themes
  { 'Dave-Elec/gruvbox', priority = 1000 },
  { 'danilo-augusto/vim-afterglow'},

  { 'stevearc/dressing.nvim',
    event = "VeryLazy",
  },
}
