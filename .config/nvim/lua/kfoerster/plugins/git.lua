return {
  {
    "sindrets/diffview.nvim",
    config = function()
      require("diffview").setup({
        default_args = {
          DiffviewOpen = { "--imply-local" },
        },
      })
      vim.keymap.set("n", "<leader>gdh", "<cmd>DiffviewOpen origin/HEAD...HEAD --imply-local<CR>") -- diff origin head with head
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
