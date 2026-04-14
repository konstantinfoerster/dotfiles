vim.schedule(function()
  vim.pack.add({
    { src = "https://github.com/mfussenegger/nvim-lint", name = "nvim-lint" },
  })

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
end)
