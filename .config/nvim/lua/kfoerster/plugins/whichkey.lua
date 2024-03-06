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

    whichkey.register({
      ["<leader>e"] = { name = "[E]xplorer", _ = "which_key_ignore" },
      ["<leader>c"] = { name = "[C]code", _ = "which_key_ignore" },
      ["<leader>g"] = { name = "[G]it", _ = "which_key_ignore" },
      ["<leader>t"] = { name = "[T]rouble", _ = "which_key_ignore" },
      ["<leader>s"] = { name = "[S]earch", _ = "which_key_ignore" },
      ["<leader>d"] = { name = "[D]iagnostics", _ = "which_key_ignore" },
    })
  end,
}
