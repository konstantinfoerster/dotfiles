return {
  "neovim/nvim-lspconfig",
  dependencies = {
    -- progress indication for lsp init
    { "j-hui/fidget.nvim", opts = {} },
    "Issafalcon/lsp-overloads.nvim",
    "hrsh7th/cmp-nvim-lsp",
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
  },
  config = function()
    vim.diagnostic.config({ virtual_text = true, severity_sort = true })
    local signs = {
      Error = " ",
      Warn = " ",
      Hint = "󰠠 ",
      Info = " ",
    }
    for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
    end

    -- add border to overlays
    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
    vim.lsp.handlers["textDocument/signatureHelp"] =
      vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })

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
        keybind({ "n", "v" }, "<leader>ca", function()
          vim.lsp.buf.code_action({ context = { only = { "quickfix", "refactor", "source" } } })
        end, "[C]ode [A]ctions")
        keybind("n", "<leader>cr", vim.lsp.buf.rename, "[C]code [R]ename")
        keybind("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", "Show buffer [D]iagnostics")
        keybind("n", "<leader>d", vim.diagnostic.open_float, "Show line [D]iagnostics")
        keybind("n", "+d", vim.diagnostic.goto_next, "Go to next diagnostic")
        keybind("n", "üd", vim.diagnostic.goto_prev,  "Go to previous diagnostic")
        keybind("n", "<leader>rr", ":LspRestart<CR>", "[R]estart LSP")

        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client.server_capabilities.signatureHelpProvider then
          require("lsp-overloads").setup(client, {})
        end
      end,
    })

    -- detect go templates
    vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
      pattern = { "*.gohtml" },
      callback = function()
        vim.opt_local.filetype = "gotmpl"
      end,
    })

    local lsp_servers = {
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
              fieldalignment = true,
            },
            codelenses = {
              gc_details = false,
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
      run_on_start = true,
    })

    require("mason-lspconfig").setup({})

    -- configure lsp server
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())
    local lspconfig = require("lspconfig")
    for k, server in pairs(lsp_servers) do
      lspconfig[k].setup({
        settings = server.settings,
        capabilities = capabilities,
      })
    end
  end,
}
