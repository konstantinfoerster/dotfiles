return {
  "OXY2DEV/markview.nvim",
  lazy = false,
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    require("markview").setup({
      initial_state = false,
      modes = {},
    })
    vim.keymap.set("n", "<leader>rs", "<Cmd>Markview splitToggle<CR>", { desc = "[R]ender [S]split" })
  end,
}
