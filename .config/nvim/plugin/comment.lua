vim.api.nvim_create_autocmd("UIEnter", {
  once = true,
  callback = vim.schedule_wrap(function()
    vim.pack.add({
      { src = "https://github.com/numToStr/Comment.nvim", name = "Comment.nvim" },
    })
    require("Comment").setup()
  end),
})
