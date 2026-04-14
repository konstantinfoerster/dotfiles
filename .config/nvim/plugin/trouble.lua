vim.schedule(function()
  vim.pack.add({
    { src = "https://github.com/nvim-tree/nvim-web-devicons", name = "nvim-web-devicons" },
    { src = "https://github.com/folke/trouble.nvim", name = "trouble.nvim" },
  })

  require("trouble").setup()

  vim.keymap.set("n", "<leader>tt", "<Cmd>Trouble diagnostics toggle<CR>", { desc = "Toggle [T]rouble" })
  vim.keymap.set("n", "<leader>tn", function()
    require("trouble").next({ skip_groups = true, jump = true })
  end, { desc = "[T]rouble [N]ext item" })
  vim.keymap.set("n", "<leader>tp", function()
    require("trouble").previous({ skip_groups = true, jump = true })
  end, { desc = "[T]rouble [P]revious item" })
end)
