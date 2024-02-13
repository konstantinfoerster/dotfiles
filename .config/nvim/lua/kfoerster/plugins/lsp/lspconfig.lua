return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    { "antosha417/nvim-lsp-file-operations", config = true },
    "Issafalcon/lsp-overloads.nvim",
    "j-hui/fidget.nvim", -- progress indication for lsp init
    "lvimuser/lsp-inlayhints.nvim", -- rust-tools already provides this feature, but gopls doesn't
  },
  config = function()
    require("fidget").setup()

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

    -- with active border the cursor sometimes get stuck, don't know why :(
    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
    --
    --     vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
    --       vim.lsp.handlers.signature_help,
    --       { border = "rounded" }
    --     )

    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(args)
        local bufnr = args.buf
        local keybind = function(mode, key, cmd, desc)
          local opts = { noremap = true, silent = true, buffer = bufnr, desc = desc }
          vim.keymap.set(mode, key, cmd, opts)
        end

        -- set keybindings
        keybind("n", "gr", "<cmd>Telescope lsp_references<CR>", "[g] to LSP [r]eferences")
        keybind("n", "gD", vim.lsp.buf.declaration, "[g]o to [D]eclaration")
        keybind("n", "gd", "<cmd>Telescope lsp_definitions<CR>", "[g]o to LSP [d]efinitions")
        keybind("n", "gi", "<cmd>Telescope lsp_implementations<CR>", "[g]o to LSP [i]mplementations")
        keybind("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", "[g]o to LSP [t]ype definitions")
        keybind("n", "<C-p>", vim.lsp.buf.signature_help, "Show function signature")
        keybind("n", "K", vim.lsp.buf.hover, "Show documentation for what is under cursor")
        keybind({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "See available [c]ode [a]ctions")
        keybind("n", "<leader>rn", vim.lsp.buf.rename, "Smart rename")
        keybind("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", "Show buffer diagnostics")
        keybind("n", "<leader>d", vim.diagnostic.open_float, "Show line diagnostics")
        --        keybind("n", "<leader>dh", vim.diagnostic.goto_prev,  "Go to previous diagnostic") replaced by trouble?
        --        keybind("n", "<leader>dl", vim.diagnostic.goto_next, "Go to next diagnostic") replaced by trouble ?
        keybind("n", "<leader>rs", ":LspRestart<CR>", "Restart LSP")

        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client.server_capabilities.signatureHelpProvider then
          require("lsp-overloads").setup(client, {})
        end
      end,
    })

    local lspconfig = require("lspconfig")
    local lsp_defaults = lspconfig.util.default_config
    lsp_defaults.capabilities =
      vim.tbl_deep_extend("force", lsp_defaults.capabilities, require("cmp_nvim_lsp").default_capabilities())

    -- lsp server that do not require any configuration
    local servers = { "html", "tsserver", "emmet_ls", "pyright", "vuels", "yamlls" }
    for _, s in pairs(servers) do
      lspconfig[s].setup({})
    end

    lspconfig["gopls"].setup({
      --       on_attach = function(client, bufnr)
      --         require("lsp-inlayhints").setup({
      --          inlay_hints = {type_hints = {prefix = "=> "}}
      --         })
      --         require("lsp-inlayhints").on_attach(client, bufnr)
      --         workaround for gopls not supporting semanticTokensProvider
      --         https://github.com/golang/go/issues/54531#issuecomment-1464982242
      --         if not client.server_capabilities.semanticTokensProvider then
      --          local semantic = client.config.capabilities.textDocument.semanticTokens
      --          client.server_capabilities.semanticTokensProvider = {
      --            full = true,
      --            legend = {
      --              tokenTypes = semantic.tokenTypes,
      --              tokenModifiers = semantic.tokenModifiers,
      --            },
      --            range = true,
      --          }
      --         end
      --       end,
      settings = {
        gopls = {
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

    lspconfig["lua_ls"].setup({
      settings = { -- custom settings for lua
        Lua = {
          -- make the language server recognize "vim" global
          diagnostics = {
            globals = { "vim" },
          },
          workspace = {
            -- make language server aware of runtime files
            library = {
              [vim.fn.expand("$VIMRUNTIME/lua")] = true,
              [vim.fn.stdpath("config") .. "/lua"] = true,
            },
          },
        },
      },
    })
  end,
}
