return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
  },
  config = function()
    -- import mason
    local mason = require("mason")

    local lsp_zero = require('lsp-zero')

    lsp_zero.on_attach(function(client, bufnr)
      -- see :help lsp-zero-keybindings
      -- to learn the available actions
      lsp_zero.default_keymaps({buffer = bufnr})
    end)

    -- import mason-lspconfig
    local mason_lspconfig = require("mason-lspconfig")

    local mason_tool_installer = require("mason-tool-installer")

    -- enable mason and configure icons
    mason.setup({
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    })

    mason_lspconfig.setup({
      -- list of servers for mason to install
      ensure_installed = {
        "tsserver",
        "html",
        "cssls",
        "tailwindcss",
        "svelte",
        "lua_ls",
        "graphql",
        "emmet_ls",
        "prismals",
        "pyright",
        "gopls",
        "sqlls",
        "solidity",
        "rust_analyzer",
        "clangd",
        -- "nimls",
      },
      -- auto-install configured servers (with lspconfig)
      automatic_installation = false, -- not the same as ensure_installed
      handlers = {
        lsp_zero.default_setup,
        -- nimls = function()
        --   require('lspconfig').nimls.setup({
        --     ---
        --     -- in here you can add your own
        --     -- custom configuration
        --     ---
        --   })
        -- end,
      },
    })

    mason_tool_installer.setup({
      ensure_installed = {
        "prettier", -- prettier formatter
        "stylua", -- lua formatter
        "isort", -- python formatter
        "black", -- python formatter
        "pylint", -- python linter
        "eslint_d", -- js linter
        "gopls",
        "sqlls",
        "solidity",
        "rust_analyzer",
        "rustfmt",
        "codelldb",
        "cpptools",
        "clangd",
        -- "cpplint",
        -- "clang-format",
        -- "nimls",
      },
    })
  end,
}

