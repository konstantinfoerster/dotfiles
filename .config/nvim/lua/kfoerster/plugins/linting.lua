return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local lint = require("lint")
    lint.linters_by_ft = {
      javascript = { "eslint_d" },
      typescript = { "eslint_d" },
      yaml = { "yamllint" },
      sh = { "shellcheck" },
      lua = { "luacheck" },
      go = { "golangcilint" },
    }

    -- local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
    -- vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
    --   pattern = { "*.ts", "*.js", "*.yml", "*.yaml" },
    --   group = lint_augroup,
    --   callback = function()
    --     lint.try_lint()
    --   end,
    -- })

    vim.keymap.set({ "n" }, "<leader>l", function()
      lint.try_lint()
    end, { desc = "[L]int file" })
  end,
}
