-- vimwiki configuration needs to be done before plugin is loaded
vim.g.vimwiki_global_ext = 0
vim.g.vimwiki_conceallevel = 0
vim.g.vimwiki_list = {
  {
    path = "~/vimwiki/",
    syntax = "markdown",
    ext = ".md",
  },
}

vim.api.nvim_create_autocmd("UIEnter", {
  once = true,
  callback = vim.schedule_wrap(function()
    vim.pack.add({
      { src = "https://github.com/vimwiki/vimwiki", name = "vimwiki" },
    })

    -- use markdown parser for vimwiki filetype
    vim.treesitter.language.register("markdown", "vimwiki")
  end),
})
