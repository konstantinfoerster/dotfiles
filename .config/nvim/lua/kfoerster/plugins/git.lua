return {
  {
    "sindrets/diffview.nvim",
    event = "VeryLazy",
    config = function()
      require("diffview").setup({
        default_args = {
          DiffviewOpen = { "--imply-local" },
        },
      })
      vim.keymap.set(
        "n",
        "<leader>gdh",
        "<cmd>DiffviewOpen origin/HEAD...HEAD<CR>",
        { desc = "[G]it [D]iff [H]ead" }
      )
      vim.keymap.set("n", "<leader>gd", "<cmd>DiffviewOpen<CR>", { desc = "[G]it [D]iff view" })
    end,
  },
  {
    -- highlight changed lines
    "lewis6991/gitsigns.nvim",
    event = "VeryLazy",
    config = function()
      require("gitsigns").setup({
        signs = {
          add = { text = "+" },
          change = { text = "~" },
          delete = { text = "_" },
          topdelete = { text = "‾" },
          changedelete = { text = "~" },
        },
      })

      vim.keymap.set("n", "<leader>gp", ":Gitsigns preview_hunk<CR>", { desc = "[G]it hunk [P]review" })
    end,
  },
}
