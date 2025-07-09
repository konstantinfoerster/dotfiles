return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "mason-org/mason.nvim",
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
        keybind("n", "<leader>tD", "<cmd>Telescope diagnostics bufnr=0<CR>", "Show buffer [D]iagnostics")
        keybind("n", "<leader>td", vim.diagnostic.open_float, "Show line [D]iagnostics")
        keybind("n", "<leader>rr", ":LspRestart<CR>", "[R]estart LSP")
      end,
    })

    local mason_packages = {
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
    }

    local capabilities = require("blink.cmp").get_lsp_capabilities(vim.lsp.protocol.make_client_capabilities())
    vim.lsp.config("*", {
      capabilities = capabilities,
    })
    -- frontend stuff
    vim.lsp.enable("cssls")
    table.insert(mason_packages, "css-lsp")
    -- typescript + vue3
    vim.lsp.config("vtsls", {
      before_init = function(_, config)
        local vuePluginConfig = {
          name = "@vue/typescript-plugin",
          location = vim.fn.expand("$MASON/packages/vue-language-server/node_modules/@vue/language-server"),
          languages = { "vue" },
          configNamespace = "typescript",
          enableForWorkspaceTypeScriptVersions = true,
        }
        table.insert(config.settings.vtsls.tsserver.globalPlugins, vuePluginConfig)
      end,
      filetypes = {
        "javascript",
        "javascriptreact",
        "javascript.jsx",
        "typescript",
        "typescriptreact",
        "typescript.tsx",
        "vue",
      },
      settings = {
        complete_function_calls = true,
        vtsls = {
          tsserver = {
            globalPlugins = {},
          },
          enableMoveToFileCodeAction = true,
          autoUseWorkspaceTsdk = true,
          experimental = {
            completion = {
              enableServerSideFuzzyMatch = true,
            },
          },
        },
        typescript = {
          updateImportsOnFileMove = { enabled = "always" },
          suggest = {
            completeFunctionCalls = true,
          },
        },
      },
    })
    vim.lsp.enable("vtsls")
    table.insert(mason_packages, "vtsls")
    vim.lsp.config("vue_ls", {
      -- check https://github.com/vuejs/language-tools/wiki/Neovim
      on_init = function(client)
        client.handlers["tsserver/request"] = function(_, result, context)
          local clients = vim.lsp.get_clients({ bufnr = context.bufnr, name = "vtsls" })
          if #clients == 0 then
            vim.notify("Could not found `vtsls` lsp client, vue_lsp would not work without it.", vim.log.levels.ERROR)
            return
          end
          local ts_client = clients[1]

          local param = unpack(result)
          local id, command, payload = unpack(param)
          ts_client:exec_cmd({
            title = "vue_request_forward", -- You can give title anything as it's used to represent a command in the UI, `:h Client:exec_cmd`
            command = "typescript.tsserverRequest",
            arguments = {
              command,
              payload,
            },
          }, { bufnr = context.bufnr }, function(_, r)
            local response_data = { { id, r.body } }
            ---@diagnostic disable-next-line: param-type-mismatch
            client:notify("tsserver/response", response_data)
          end)
        end
      end,
    })
    vim.lsp.enable("vue_ls")
    table.insert(mason_packages, "vue-language-server")

    -- backend stuff
    -- add filetypes for go templates
    vim.filetype.add({
      extension = {
        gotmpl = "gotmpl",
        gohtml = "gotmpl",
      },
    })

    vim.lsp.config("gopls", {
      settings = {
        gopls = {
          templateExtensions = { "gohtml", "gotmpl", "tmpl" },
          analyses = {
            nilness = true,
            shadow = true,
            unusedparams = true,
            unusedwrite = true,
            useany = true,
            ST1000 = false, -- missing package comments
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
    })
    vim.lsp.enable("gopls")
    table.insert(mason_packages, "gopls")
    vim.lsp.config("lua_ls", {
      settings = {
        Lua = {
          runtime = {
            version = "LuaJIT",
          },
          diagnostics = {
            -- Get the language server to recognize the `vim` global
            globals = {
              "vim",
              "require",
            },
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
    })
    vim.lsp.enable("lua_ls")
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
  end,
}
