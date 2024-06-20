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
      vim.keymap.set("n", "<leader>gdh", "<cmd>DiffviewOpen origin/HEAD...HEAD<CR>", { desc = "[G]it [D]iff [H]ead" })
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
        on_attach = function(bufnr)
          local gitsigns = require("gitsigns")

          local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
          end

          map("n", "<leader>gp", ":Gitsigns preview_hunk<CR>", { desc = "[G]it hunk [P]review" })
          map("n", "<leader>gb", function()
            gitsigns.blame_line()
          end, { desc = "[G]it line [B]lame" })
          map("n", "<leader>gdl", function()
            gitsigns.diffthis()
          end, { desc = "[G]it [D]ff [L]ine" })
        end,
      })
    end,
  },
}
