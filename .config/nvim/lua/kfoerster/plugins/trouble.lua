return {
  "folke/trouble.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("trouble").setup({ icons = true })

    local opts = { noremap = true, silent = true }
    vim.keymap.set("n", "<leader>tt", "<Cmd>TroubleToggle<CR>", opts)
    --    vim.keymap.set("n", "<leader>qq", "<Cmd>TroubleToggle quickfix<CR>", opts)
    --    vim.keymap.set("n", "<leader>ql", "<Cmd>TroubleToggle loclist<CR>", opts)
    --    vim.keymap.set("n", "<leader>qd", "<Cmd>TroubleToggle document_diagnostics<CR>", opts)
    --    vim.keymap.set("n", "<leader>qw", "<Cmd>TroubleToggle workspace_diagnostics<CR>", opts)
    vim.keymap.set("n", "<leader>tl", function()
      require("trouble").next({ skip_groups = true, jump = true })
    end)
    vim.keymap.set("n", "<leader>th", function()
      require("trouble").previous({ skip_groups = true, jump = true })
    end)
    vim.keymap.set("n", "tk", function()
      require("trouble").next({ skip_groups = true, jump = true })
    end)
    vim.keymap.set("n", "tj", function()
      require("trouble").previous({ skip_groups = true, jump = true })
    end)
  end,
}
