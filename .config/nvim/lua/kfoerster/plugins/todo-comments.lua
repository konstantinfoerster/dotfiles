return {
  "folke/todo-comments.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  event = "BufRead",
  config = function()
    require("todo-comments").setup({
      signs = false,
    })
    vim.keymap.set("n", "<leader>st", "<Cmd>TodoTelescope<CR>", { desc = "[S]earch [T]odos" })
    vim.keymap.set("n", "<leader>tc", "<Cmd>TodoTrouble<CR>", { desc = "[T]rouble [C]omments" })
  end,
}
