-- enable undotree
vim.cmd.packadd("nvim.undotree")
vim.keymap.set("n", "<leader>u", require("undotree").open, { desc = "Toggle [U]ndotree" })

-- enable difftool
vim.cmd.packadd("nvim.difftool")

vim.api.nvim_create_autocmd("UIEnter", {
  once = true,
  callback = vim.schedule_wrap(function()
    vim.pack.add({
      { src = "https://github.com/numToStr/Comment.nvim", name = "Comment.nvim" },
    })
    require("Comment").setup()
  end),
})
