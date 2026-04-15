vim.api.nvim_create_autocmd("UIEnter", {
  once = true,
  callback = vim.schedule_wrap(function()
    -- close html tags automatically
    vim.pack.add({
      { src = "https://github.com/windwp/nvim-ts-autotag", name = "nvim-ts-autotag" },
      { src = "https://github.com/folke/trouble.nvim", name = "trouble.nvim" },
    })

    require("nvim-ts-autotag").setup({})

    require("trouble").setup()
    vim.keymap.set("n", "<leader>tt", "<Cmd>Trouble diagnostics toggle<CR>", { desc = "Toggle [T]rouble" })
    vim.keymap.set("n", "<leader>tn", function()
      require("trouble").next({ skip_groups = true, jump = true })
    end, { desc = "[T]rouble [N]ext item" })
    vim.keymap.set("n", "<leader>tp", function()
      require("trouble").previous({ skip_groups = true, jump = true })
    end, { desc = "[T]rouble [P]revious item" })
  end),
})

vim.api.nvim_create_autocmd({ "BufReadPre", "BufNewFile" }, {
  once = true,
  callback = vim.schedule_wrap(function()
    vim.pack.add({
      { src = "https://github.com/stevearc/conform.nvim", name = "conform.nvim" },
      { src = "https://github.com/mfussenegger/nvim-lint", name = "nvim-lint" },
    })

    local conform = require("conform")
    conform.setup({
      formatters_by_ft = {
        go = { "gofmt", "goimports" },
        lua = { "stylua" },
        python = { "black" },
        javascript = { "prettierd", "prettier", stop_after_first = true },
        typescript = { "prettierd", "prettier", stop_after_first = true },
        html = { "prettierd", "prettier", stop_after_first = true },
        markdown = { "prettierd", "prettier", stop_after_first = true },
        vimwiki = { "prettierd", "prettier", stop_after_first = true },
        css = { "prettierd", "prettier", stop_after_first = true },
        json = { "prettierd", "prettier", stop_after_first = true },
        yaml = { "prettierd", "prettier", stop_after_first = true },
      },
      -- no automatic formatting for now
      --       format_on_save = {
      --         lsp_format = "fallback",
      --         async = false,
      --         timeout = 500,
      --       },
    })
    vim.keymap.set({ "n", "v" }, "<leader>f", function()
      conform.format({
        lsp_format = "fallback",
        async = false,
        timeout = 500,
      })
    end, { desc = "[F]ormat file or range (in visual mode)" })

    local lint = require("lint")
    lint.linters_by_ft = {
      javascript = { "eslint_d" },
      typescript = { "eslint_d" },
      yaml = { "yamllint" },
      sh = { "shellcheck" },
      lua = { "luacheck" },
      go = { "golangcilint" },
    }
    vim.keymap.set({ "n" }, "<leader>l", function()
      lint.try_lint()
    end, { desc = "[L]int file" })
  end),
})
