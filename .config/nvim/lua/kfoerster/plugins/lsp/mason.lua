return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
  },
  config = function()
    local mason = require("mason")
    mason.setup({
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    })

    local mason_lspconfig = require("mason-lspconfig")
    mason_lspconfig.setup({
      -- list of servers for mason to install
      ensure_installed = {
        "tsserver",
        "html",
--        "htmx", -- requires rust
        "lua_ls",
        "emmet_ls", -- js
        "pyright", -- python
        "gopls", -- go
        "omnisharp", -- c#
        "vuels", -- vuejs
--         "java_language_server",
        "yamlls"
      },
      -- auto-install configured servers (with lspconfig)
      automatic_installation = true, -- not the same as ensure_installed
    })
  end,
}
