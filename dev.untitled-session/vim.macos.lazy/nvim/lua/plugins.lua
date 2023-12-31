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

      -- vim.g.mkdp_auto_close = 1
    end,
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
  },
  {
    'jghauser/follow-md-links.nvim',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
    },
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
    config = function()
      require'nvim-tree'.setup({
        view = {
          adaptive_size = true
        },
        filters = {
          git_ignored = false,
        }
      })
    end,
  },
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
      "nvim-treesitter/playground",
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
        playground = {
          enable = true,
          disable = {},
          updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
          persist_queries = false, -- Whether the query persists across vim sessions
          keybindings = {
            toggle_query_editor = 'o',
            toggle_hl_groups = 'i',
            toggle_injected_languages = 't',
            toggle_anonymous_nodes = 'a',
            toggle_language_display = 'I',
            focus_language = 'f',
            unfocus_language = 'F',
            update = 'R',
            goto_node = '<cr>',
            show_help = '?',
          },
        }
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
  -- {
  --  "Arekkusuva/jira-nvim",
  --  dependencies = {
  --    "nvim-telescope/telescope.nvim",
  --  },
  --  build = "make build",
  --  config = function()
  --    require("jira-nvim").setup({
  --      host = os.getenv("JIRA_PROJECT"),
  --      token_path = os.getenv("JIRA_TOKEN_PATH")
  --    })
  --  end
  --},

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

  {
    'mfussenegger/nvim-lint',
    setup = function()
      require('lint').linters_by_ft = {
        markdown = {'vale',},
        go = {"golangcilint", },
        golang = {"golangcilint", },
      }
      vim.api.nvim_create_autocmd({ "BufWritePost" }, {
        callback = function()
          require("lint").try_lint()
        end,
      })
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
      "mfussenegger/nvim-dap",
      "neovim/nvim-lspconfig",
      "ray-x/lsp_signature.nvim",
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
    "ray-x/lsp_signature.nvim",
    event = "VeryLazy",
    opts = {},
    config = function(_, opts) require'lsp_signature'.setup(opts) end
  },

  {
    "ray-x/guihua.lua",
    build = 'cd lua/fzy && make'
  },

  {
    "mfussenegger/nvim-dap",
    config = function ()

      local dap = require('dap')
      dap.configurations.python = {
        {
          type = 'python',
          request = 'launch',
          name = "Launch file",
          program = "${file}",
        },
      }
    end
  },

  {
    "mfussenegger/nvim-dap-python",
    dependencies = {
      "mfussenegger/nvim-dap",
    },
    config = function ()
      local dap = require('dap')
      dap.configurations.python = {
        {
          type = 'python',
          request = 'launch',
          name = "Launch file",
          program = "${file}",
        },
      }

      local venv = os.getenv("VIRTUAL_ENV")
      if venv ~= nil then
        local python_path = venv.."/bin/python"
        require('dap-python').setup(python_path)
      end
    end
  },

  {
    "rcarriga/nvim-dap-ui",
    config = function ()
      require("dapui").setup()
      -- require("nvim-dap-ui").setup({})
    end
  },
  {
    "theHamsta/nvim-dap-virtual-text",
    setup = function ()
        require("nvim-dap-virtual-text").setup()
    end
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
    "alfredodeza/pytest.vim",
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

  -- ORG MODE
  -- {
  -- 'nvim-orgmode/orgmode',
  --   dependencies = {
  --     { 'nvim-treesitter/nvim-treesitter', lazy = true },
  --   },
  --   event = 'VeryLazy',
  --   config = function()
  --     -- Load treesitter grammar for org
  --     require('orgmode').setup_ts_grammar()

  --     -- Setup treesitter
  --     require('nvim-treesitter.configs').setup({
  --       highlight = {
  --         enable = true,
  --         additional_vim_regex_highlighting = { 'org' },
  --       },
  --       ensure_installed = { 'org' },
  --     })

  --     -- Setup orgmode
  --     require('orgmode').setup({
  --       org_agenda_files = '~/orgfiles/**/*',
  --       org_default_notes_file = '~/orgfiles/refile.org',
  --     })
  --   end,
  -- },
  { "dhruvasagar/vim-table-mode" },

  {'akinsho/toggleterm.nvim', version = "*", opts = {--[[ things you want to change go here]]}},

  {
    "sopa0/telescope-makefile",
    dependencies = {
      "akinsho/toggleterm.nvim",
      'nvim-telescope/telescope.nvim'
    },
    config = function()
      require'telescope'.load_extension('make')
    end
  },

  {
    'LukasPietzschmann/telescope-tabs',
    dependencies = {
      'nvim-telescope/telescope.nvim'
    },
    config = function ()
      require'telescope-tabs'.setup{
        -- Your custom config :^)
      }
    end
  },

  {
    'terrortylor/nvim-comment',
    config = function ()
      require('nvim_comment').setup({
        comment_empty = false
      })
    end
  },

  { "typicode/bg.nvim", lazy = false },

  -- EXTERNAL services
  {
    'napisani/nvim-github-codesearch',
    build = 'make',
    config = function ()
      local gh = require("nvim-github-codesearch")
      gh.setup({
        github_auth_token = "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"
      })
      vim.keymap.set("n", "gh", ":lua require('nvim-github-codesearch').prompt()<CR>", {})
    end
  },


  -- themes
  { 'Dave-Elec/gruvbox', priority = 1000 },
  { 'danilo-augusto/vim-afterglow'},

  { 'stevearc/dressing.nvim',
    event = "VeryLazy",
  },
}
