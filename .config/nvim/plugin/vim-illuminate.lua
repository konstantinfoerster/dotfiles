vim.schedule(function()
  vim.pack.add({
    { src = "https://github.com/RRethy/vim-illuminate", name = "vim-illuminate" },
  })

  require("illuminate").configure({})
end)
