return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 600
  end,
  config = function()
    local whichkey = require("which-key")
    whichkey.setup()

    whichkey.add({
      { "<leader>e", desc = "[E]xplorer" },
      { "<leader>c", desc = "[C]code" },
      { "<leader>g", desc = "[G]it" },
      { "<leader>t", desc = "[T]rouble" },
      { "<leader>s", desc = "[S]earch" },
   })
  end,
}
