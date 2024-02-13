return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
  },
  config = function()
    require("mason").setup({
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    })

    require("mason-tool-installer").setup({
      ensure_installed = {
        -- formatter
        "prettier", -- js, ts
        "prettierd", -- js, ts
        "stylua", -- lua

        -- linter
        -- "luacheck", -- fails with: luarocks failed with exit. Installed via system package.
        "eslint_d", -- js, ts
        "golangci-lint", -- golang
        "yamllint", -- yaml
        "shellcheck", -- shell
      },
      auto_update = false,
      run_on_start = true,
    })

    require("mason-lspconfig").setup({
      -- list of servers for mason to install
      ensure_installed = {
        "tsserver",
        "html",
        --        "htmx", -- requires rust
        "lua_ls",
        "emmet_ls", -- js
        "pyright", -- python
        "gopls", -- go
        "vuels", -- vuejs
        --         "java_language_server",
        "yamlls",
      },
      -- auto-install configured servers (with lspconfig)
      automatic_installation = true, -- not the same as ensure_installed
    })
  end,
}
