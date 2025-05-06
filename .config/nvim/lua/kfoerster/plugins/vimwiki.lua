return {
  "vimwiki/vimwiki",
  lazy = false,
  init = function()
    vim.g.vimwiki_global_ext = 0
    vim.g.vimwiki_list = {
      {
        path = "~/vimwiki/",
        syntax = "markdown",
        ext = ".md",
      },
    }
  end,
}
