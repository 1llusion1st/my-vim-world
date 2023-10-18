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
    config = function ()
      vim.api.nvim_exec([[
function OpenMarkdownPreview (url)
  execute "silent ! firefox --new-window " . a:url
endfunction
let g:mkdp_browserfunc = 'OpenMarkdownPreview'
      ]], true)

      vim.g.mkdp_auto_close = 1
    end,
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
    config = function() require'nvim-tree'.setup {
      filters = {
        git_ignored = false,
      }
    } end, },
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
  {
    'nvim-treesitter/nvim-treesitter',
    event = { "BufReadPre", "BufNewFile" },
    build = ":TSUpdate",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
      "windwp/nvim-ts-autotag",
    },
    config = function()
      -- import nvim-treesitter plugin
      local treesitter = require("nvim-treesitter.configs")

      -- configure treesitter
      treesitter.setup({ -- enable syntax highlighting
        highlight = {
          enable = true,
        },
        -- enable indentation
        indent = { enable = true },
        -- enable autotagging (w/ nvim-ts-autotag plugin)
        autotag = {
          enable = true,
        },
        -- ensure these language parsers are installed
        ensure_installed = {
          "json",
          "javascript",
          "typescript",
          "tsx",
          "yaml",
          "html",
          "css",
          "prisma",
          "markdown",
          "markdown_inline",
          "svelte",
          "graphql",
          "bash",
          "lua",
          "vim",
          "dockerfile",
          "gitignore",
          "query",
          "go",
          "sql",
          "solidity",
          "python",
        },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<C-space>",
            node_incremental = "<C-space>",
            scope_incremental = false,
            node_decremental = "<bs>",
          },
        },
        -- enable nvim-ts-context-commentstring plugin for commenting tsx and jsx
        context_commentstring = {
          enable = true,
          enable_autocmd = false,
        },
      })
    end,
  },
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
          completeopt = "menu,menuone,preview,noselect",
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
  { 'junegunn/gv.vim' },

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

  -- context
  { "nvim-treesitter/nvim-treesitter-context" },
  -- {
  --   'nvimdev/lspsaga.nvim',
  --   config = function()
  --       require('lspsaga').setup({})
  --   end,
  --   dependencies = {
  --       'nvim-treesitter/nvim-treesitter',-- optional
  --       'nvim-tree/nvim-web-devicons'     -- optional
  --  }
  -- },

  -- firevim - support for browser extensions
  {
    'glacambre/firenvim',

    -- Lazy load firenvim
    -- Explanation: https://github.com/folke/lazy.nvim/discussions/463#discussioncomment-4819297
    -- lazy = not vim.g.started_by_firenvim,
    lazy = false,
    build = function()
        vim.fn["firenvim#install"](0)
    end
  },

  -- special language libraries
  -- go
  -- { 'fatih/vim-go',
  --  config = function()
  --      vim.keymap.set("n", "<space>F", "<cmd>GoFillStruct<CR>", { desc = "fill current struct" })
  --  end
  --},
  {
    'ray-x/go.nvim',
    dependencies = {  -- optional packages
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function ()
      require("go").setup()
    end,
    event = {"CmdlineEnter"},
    ft = {"go", 'gomod'},
    build = ':lua require("go.install").update_all_sync()' -- if you need to install/update all binaries
  },
  {
    '1llusion1st/nvim-json2gostruct',
  },
  { 'crusj/structrue-go.nvim' },
  {
		'edolphin-ydf/goimpl.nvim',
		dependencies = {
			{'nvim-lua/plenary.nvim'},
			{'nvim-lua/popup.nvim'},
			{'nvim-telescope/telescope.nvim'},
			{'nvim-treesitter/nvim-treesitter'},
		},
		config = function()
			require'telescope'.load_extension'goimpl'
		end,
	},


  {
    'Wansmer/treesj',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    config = function()
      require('treesj').setup({
        max_join_length = 1024,
      })
    end,
  },

  -- db explorers
  {
    'https://github.com/kndndrj/nvim-dbee',
    dependencies = {
      "MunifTanjim/nui.nvim",
    },
    build = function()
      -- Install tries to automatically detect the install method.
      -- if it fails, try calling it with one of these parameters:
      --    "curl", "wget", "bitsadmin", "go"
      require("dbee").install()
    end,
    config = function()
      require("dbee").setup(--[[optional config]])
    end,
  },
  {
    'kristijanhusak/vim-dadbod-ui',
    dependencies = {
      { 'tpope/vim-dadbod', lazy = true },
      { 'kristijanhusak/vim-dadbod-completion', ft = { 'sql', 'mysql', 'plsql' }, lazy = true },
    },
    cmd = {
      'DBUI',
      'DBUIToggle',
      'DBUIAddConnection',
      'DBUIFindBuffer',
    },
    init = function()
      -- Your DBUI configuration
      vim.g.db_ui_use_nerd_fonts = 1
    end,
  },

  -- code actions
  {
    "aznhe21/actions-preview.nvim",
    config = function()
      vim.keymap.set({ "v", "n" }, "gf", require("actions-preview").code_actions)
    end,
  },

  -- lsp inline diagnostics
  {
    "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    config = function()
      require("lsp_lines").setup()
    end,
  },

  -- themes
  { 'Dave-Elec/gruvbox', priority = 1000 },
  { 'danilo-augusto/vim-afterglow'},

  { 'stevearc/dressing.nvim',
    event = "VeryLazy",
  },
}
