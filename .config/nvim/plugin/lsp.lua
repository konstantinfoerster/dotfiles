vim.schedule(function()
  vim.pack.add({
    { src = "https://github.com/saghen/blink.cmp", name = "blink.cmp", version = vim.version.range("1.x") },
    { src = "https://github.com/neovim/nvim-lspconfig", name = "nvim-lspconfig" },
    { src = "https://github.com/mason-org/mason.nvim", name = "mason.nvim" },
    { src = "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim", name = "mason-tool-installer.nvim" },
    { src = "https://github.com/j-hui/fidget.nvim", name = "fidget.nvim" },
  })

  -- shows LSP progress messages
  require("fidget").setup({})

  require("blink.cmp").setup({
    enabled = function()
      return not vim.tbl_contains({ "NvimTree" }, vim.bo.filetype)
    end,
    -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
    -- 'super-tab' for mappings similar to vscode (tab to accept)
    -- 'enter' for enter to accept
    -- 'none' for no mappings
    --
    -- All presets have the following mappings:
    -- C-space: Open menu or open docs if already open
    -- C-n/C-p or Up/Down: Select next/previous item
    -- C-e: Hide menu
    -- C-k: Toggle signature help (if signature.enabled = true)
    --
    -- See :h blink-cmp-config-keymap for defining your own keymap
    keymap = {
      preset = "enter",

      ["<C-k>"] = { "select_prev", "fallback" },
      ["<C-j>"] = { "select_next", "fallback" },
    },
    appearance = {
      nerd_font_variant = "mono",
      kind_icons = {
        -- codicons from lspkind
        Text = "󰉿",
        Method = "󰆧",
        Function = "󰊕",
        Constructor = "",
        Field = "󰜢",
        Variable = "󰀫",
        Class = "󰠱",
        Interface = "",
        Module = "",
        Property = "󰜢",
        Unit = "󰑭",
        Value = "󰎠",
        Enum = "",
        Keyword = "󰌋",
        Snippet = "",
        Color = "󰏘",
        File = "󰈙",
        Reference = "󰈇",
        Folder = "󰉋",
        EnumMember = "",
        Constant = "󰏿",
        Struct = "󰙅",
        Event = "",
        Operator = "󰆕",
        TypeParameter = "",
      },
    },
    completion = {
      documentation = {
        auto_show = true,
      },
      trigger = {
        -- do not show completion menu when entering insert mode
        show_on_insert_on_trigger_character = false,
      },
      menu = {
        draw = {
          columns = {
            { "label", "label_description", gap = 1 },
            { "kind_icon", "kind", gap = 1 },
            { "source_id" },
          },
          components = {
            kind_icon = {
              text = function(ctx)
                local icon = ctx.kind_icon
                if vim.tbl_contains({ "Path" }, ctx.source_name) then
                  local dev_icon, _ = require("nvim-web-devicons").get_icon(ctx.label)
                  if dev_icon then
                    icon = dev_icon
                  end
                end

                return icon .. ctx.icon_gap
              end,
            },
          },
        },
      },
    },
    signature = { enabled = true },
    sources = {
      default = { "lsp", "path", "buffer" },
    },
    fuzzy = { implementation = "prefer_rust_with_warning" },
  })

  vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
      local bufnr = args.buf
      local keybind = function(mode, key, cmd, desc)
        local opts = { noremap = true, silent = true, buffer = bufnr, desc = desc }
        vim.keymap.set(mode, key, cmd, opts)
      end

      keybind("n", "gr", "<cmd>FzfLua lsp_references<CR>", "[G]oto [R]eferences")
      keybind("n", "gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
      keybind("n", "gd", "<cmd>FzfLua lsp_definitions<CR>", "[G]oto [D]efinitions")
      keybind("n", "gi", "<cmd>FzfLua lsp_implementations<CR>", "[G]oto [I]mplementations")
      keybind("n", "gt", "<cmd>FzfLua lsp_typedefs<CR>", "[G]oto [T]ype definitions")
      keybind("n", "<C-k>", vim.lsp.buf.signature_help, "Show signature for currently completing func")
      keybind("n", "K", vim.lsp.buf.hover, "Show documentation about the word under cursor")
      keybind({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ctions")
      keybind("n", "<leader>cr", vim.lsp.buf.rename, "[C]ode [R]ename")
      keybind("n", "<leader>tD", "<cmd>FzfLua lsp_document_diagnostics<CR>", "Show document [D]iagnostics")
      keybind("n", "<leader>rr", ":LspRestart<CR>", "[R]estart LSP")
    end,
  })

  local mason_packages = {
    -- formatter
    "goimports",
    "black",
    "prettier",
    "prettierd",
    "stylua",

    -- linter
    -- "luacheck", -- fails with: luarocks failed with exit. Installed via system package.
    "eslint_d",
    "golangci-lint",
    "yamllint",
    "shellcheck",
  }

  local capabilities = require("blink.cmp").get_lsp_capabilities(vim.lsp.protocol.make_client_capabilities())
  vim.lsp.config("*", {
    capabilities = capabilities,
  })

  -- frontend stuff
  vim.lsp.enable({ "cssls", "vtsls", "vue_ls" })
  table.insert(mason_packages, "css-lsp")
  table.insert(mason_packages, "vtsls")
  table.insert(mason_packages, "vue-language-server")

  -- backend stuff
  -- add filetypes for go templates
  vim.filetype.add({
    extension = {
      gotmpl = "gotmpl",
      gohtml = "gotmpl",
    },
  })
  vim.lsp.enable({ "gopls", "lua_ls" })
  table.insert(mason_packages, "gopls")
  table.insert(mason_packages, "lua-language-server")

  -- other stuff
  vim.lsp.enable("yamlls")
  table.insert(mason_packages, "yaml-language-server")

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
    ensure_installed = mason_packages,
    auto_update = false,
  })
end)
