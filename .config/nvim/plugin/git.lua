vim.api.nvim_create_autocmd("UIEnter", {
  once = true,
  callback = vim.schedule_wrap(function()
    vim.pack.add({
      { src = "https://github.com/sindrets/diffview.nvim", name = "diffview.nvim" },
      -- highlight changed lines
      { src = "https://github.com/lewis6991/gitsigns.nvim", name = "gitsigns.nvim" },
    })

    require("diffview").setup({
      default_args = {
        DiffviewOpen = { "--imply-local" },
      },
    })
    vim.keymap.set("n", "<leader>gD", "<cmd>DiffviewOpen origin/HEAD...HEAD<CR>", { desc = "Git [D]iff head" })
    vim.keymap.set("n", "<leader>gd", "<cmd>DiffviewOpen<CR>", { desc = "Git [d]iff view" })
    vim.keymap.set("n", "<leader>qq", "<cmd>DiffviewClose<CR>", { desc = "Close diff view" })

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
        map("n", "<leader>gl", function()
          gitsigns.diffthis()
        end, { desc = "[G]it diff [L]ine" })
      end,
    })
  end),
})
