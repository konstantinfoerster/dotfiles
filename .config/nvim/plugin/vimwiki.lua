vim.schedule(function()
  vim.g.vimwiki_global_ext = 0
  vim.g.vimwiki_list = {
    {
      path = "~/vimwiki/",
      syntax = "markdown",
      ext = ".md",
    },
  }

  vim.pack.add({
    { src = "https://github.com/vimwiki/vimwiki", name = "vimwiki" },
  })
end)
