vim.api.nvim_create_autocmd("UIEnter", {
  once = true,
  callback = vim.schedule_wrap(function()
    vim.pack.add({
      { src = "https://github.com/christoomey/vim-tmux-navigator", name = "vim-tmux-navigator" },
    })

    vim.keymap.set("n", "<c-h>", "<cmd>TmuxNavigateLeft<cr>")
    vim.keymap.set("n", "<c-j>", "<cmd>TmuxNavigateDown<cr>")
    vim.keymap.set("n", "<c-k>", "<cmd>TmuxNavigateUp<cr>")
    vim.keymap.set("n", "<c-l>", "<cmd>TmuxNavigateRight<cr>")
    vim.keymap.set("n", "<c-\\>", "<cmd>TmuxNavigatePrevious<cr>")

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
