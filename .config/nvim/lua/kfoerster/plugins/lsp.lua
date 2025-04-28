return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    -- progress indication for lsp init
    { "j-hui/fidget.nvim", opts = {} },
    "nvim-tree/nvim-web-devicons",
    "onsails/lspkind-nvim",
    {
      "saghen/blink.cmp",
      event = "InsertEnter",
      -- use a release tag to download pre-built binaries
      version = "1.*",
      opts = {
        enabled = function()
          return not vim.tbl_contains({ "NvimTree", "DressingInput" }, vim.bo.filetype)
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
        },
        completion = {
          documentation = { auto_show = true },
          menu = {
            draw = {
              components = {
                kind_icon = {
                  text = function(ctx)
                    local icon = ctx.kind_icon
                    if vim.tbl_contains({ "Path" }, ctx.source_name) then
                      local dev_icon, _ = require("nvim-web-devicons").get_icon(ctx.label)
                      if dev_icon then
                        icon = dev_icon
                      end
                    else
                      icon = require("lspkind").symbolic(ctx.kind, {
                        mode = "symbol",
                      })
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
      },
      opts_extend = { "sources.default" },
    },
  },
  config = function()
    vim.diagnostic.config({
      virtual_text = true,
      underline = { severity = vim.diagnostic.severity.ERROR },
      jump = {
        float = true,
      },
      float = {
        severity_sort = true,
        focusable = false,
        source = true,
        header = "",
      },
    })

    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(args)
        local bufnr = args.buf
        local keybind = function(mode, key, cmd, desc)
          local opts = { noremap = true, silent = true, buffer = bufnr, desc = desc }
          vim.keymap.set(mode, key, cmd, opts)
        end

        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client.name == "gopls" and not client.server_capabilities.semanticTokensProvider then
          -- workaround for https://github.com/golang/go/issues/54531
          local semantic = client.config.capabilities.textDocument.semanticTokens
          client.server_capabilities.semanticTokensProvider = {
            full = true,
            legend = {
              tokenTypes = semantic.tokenTypes,
              tokenModifiers = semantic.tokenModifiers,
            },
            range = true,
          }
        end

        -- set keybindings
        keybind("n", "gr", "<cmd>Telescope lsp_references<CR>", "[G]oto [R]eferences")
        keybind("n", "gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
        keybind("n", "gd", "<cmd>Telescope lsp_definitions<CR>", "[G]oto [D]efinitions")
        keybind("n", "gi", "<cmd>Telescope lsp_implementations<CR>", "[G]oto [I]mplementations")
        keybind("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", "[G]oto [T]ype definitions")
        keybind("n", "<C-k>", vim.lsp.buf.signature_help, "Show signature for currently completing func")
        keybind("n", "K", vim.lsp.buf.hover, "Show documentation about the word under cursor")
        keybind({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ctions")
        keybind("n", "<leader>cr", vim.lsp.buf.rename, "[C]code [R]ename")
        keybind("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", "Show buffer [D]iagnostics")
        keybind("n", "<leader>d", vim.diagnostic.open_float, "Show line [D]iagnostics")
        keybind("n", "<leader>rr", ":LspRestart<CR>", "[R]estart LSP")
      end,
    })

    -- detect go templates
    vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
      pattern = { "*.gohtml" },
      callback = function()
        vim.opt_local.filetype = "gotmpl"
      end,
    })

    local capabilities = require("blink.cmp").get_lsp_capabilities(vim.lsp.protocol.make_client_capabilities())
    local lsp_servers = {
      -- css
      cssls = {},
      -- ts, js
      ts_ls = {},
      -- js
      emmet_ls = {},
      -- vuejs
      vuels = {},
      html = {},
      -- pyhon
      pyright = {},
      -- golang
      gopls = {
        settings = {
          gopls = {
            templateExtensions = { "gohtml", "gotmpl", "tmpl" },
            analyses = {
              nilness = true,
              shadow = true,
              unusedparams = true,
              unusedwrite = true,
              useany = true,
            },
            codelenses = {
              generate = true,
              regenerate_cgo = true,
              run_govulncheck = true,
              test = true,
              tidy = true,
              upgrade_dependency = false,
              vendor = true,
            },
            staticcheck = true,
            usePlaceholders = false, -- jump to next placeholder seems broken
            -- experimentalPostfixCompletions = true,
            semanticTokens = true,
            completeUnimported = true,
            hints = {
              assignVariableTypes = true,
              compositeLiteralFields = true,
              compositeLiteralTypes = true,
              constantValues = true,
              functionTypeParameters = true,
              parameterNames = true,
              rangeVariableTypes = true,
            },
          },
        },
      },
      lua_ls = {
        settings = {
          Lua = {
            runtime = {
              version = "LuaJIT",
            },
            workspace = {
              checkThirdParty = false,
              library = {
                "${3rd}/luv/library",
                unpack(vim.api.nvim_get_runtime_file("", true)),
              },
            },
          },
        },
      },
      yamlls = {},
    }

    require("mason").setup({
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    })

    local ensure_installed = vim.tbl_keys(lsp_servers)
    vim.list_extend(ensure_installed, {
      -- formatter
      "goimports", -- golang
      "black", -- python
      "prettier", -- js, ts
      "prettierd", -- js, ts
      "stylua", -- lua

      -- linter
      -- "luacheck", -- fails with: luarocks failed with exit. Installed via system package.
      "eslint_d", -- js, ts
      "golangci-lint", -- golang
      "yamllint", -- yaml
      "shellcheck", -- shell
    })

    require("mason-tool-installer").setup({
      ensure_installed = ensure_installed,
      auto_update = false,
    })

    require("mason-lspconfig").setup({
      ensure_installed = {},
      automatic_installation = false,
      handlers = {
        function(server_name)
          local server = lsp_servers[server_name] or {}
          -- merge lsp_server capabilities overwrites with default capabilities
          server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
          require("lspconfig")[server_name].setup(server)
        end,
      },
    })
  end,
}
