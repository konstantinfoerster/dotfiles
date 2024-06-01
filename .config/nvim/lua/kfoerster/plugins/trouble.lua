return {
  "folke/trouble.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("trouble").setup()

    vim.keymap.set("n", "<leader>tt", "<Cmd>Trouble diagnostics toggle<CR>", { desc = "Toggle [T]rouble" })
    -- vim.keymap.set("n", "<leader>tt", "<Cmd>TroubleToggle document_diagnostics<CR>", { desc = "Toggle [T]rouble" })
    -- vim.keymap.set("n", "<leader>tw", "<Cmd>TroubleToggle workspace_diagnostics<CR>", { desc = "Toggle [T]rouble" })
    -- vim.keymap.set("n", "<leader>tq", "<Cmd>TroubleToggle quickfix<CR>", { desc = "Toggle [T]rouble" })
    vim.keymap.set("n", "<leader>tn", function()
      require("trouble").next({ skip_groups = true, jump = true })
    end, { desc = "[T]rouble [N]ext item" })
    vim.keymap.set("n", "<leader>tp", function()
      require("trouble").previous({ skip_groups = true, jump = true })
    end, { desc = "[T]rouble [P]revious item" })
  end,
}
