vim.schedule(function()
  vim.pack.add({
    { src = "https://github.com/numToStr/Comment.nvim", name = "Comment.nvim" },
  })
  require("Comment").setup()
end)
