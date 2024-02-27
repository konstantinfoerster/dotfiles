return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 600
  end,
  config = function()
    require("which-key").setup()
  end,
}
