vim.api.nvim_create_autocmd("BufRead", {
  once = true,
  callback = vim.schedule_wrap(function()
    vim.pack.add({
      { src = "https://github.com/nvim-lua/plenary.nvim", name = "plenary.nvim" },
      { src = "https://github.com/folke/todo-comments.nvim", name = "todo-comments.nvim" },
    })

    require("todo-comments").setup({
      signs = false,
    })

    vim.keymap.set("n", "<leader>tc", "<Cmd>TodoTrouble<CR>", { desc = "[T]rouble [C]omments" })
  end),
})
