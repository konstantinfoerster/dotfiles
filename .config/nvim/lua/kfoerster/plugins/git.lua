return {
  {
    "sindrets/diffview.nvim",
    opts = {},
    config = function()
      vim.keymap.set("n", "<leader>gdh", "<cmd>DiffviewOpen origin/HEAD...HEAD --imply-local<CR>") -- toggle file explorer
    end,
  },
  {
    -- highlight changed lines
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup()

      vim.keymap.set("n", "<leader>gp", ":Gitsigns preview_hunk<CR>")
    end,
  },
}
