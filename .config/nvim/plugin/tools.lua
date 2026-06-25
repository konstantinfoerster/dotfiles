vim.api.nvim_create_autocmd("UIEnter", {
  once = true,
  callback = vim.schedule_wrap(function()
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
  end),
})
