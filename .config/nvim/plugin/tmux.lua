vim.schedule(function()
  vim.pack.add({
    { src = "https://github.com/christoomey/vim-tmux-navigator", name = "vim-tmux-navigator" },
  })

  vim.keymap.set("n", "<c-h>", "<cmd>TmuxNavigateLeft<cr>")
  vim.keymap.set("n", "<c-j>", "<cmd>TmuxNavigateDown<cr>")
  vim.keymap.set("n", "<c-k>", "<cmd>TmuxNavigateUp<cr>")
  vim.keymap.set("n", "<c-l>", "<cmd>TmuxNavigateRight<cr>")
  vim.keymap.set("n", "<c-\\>", "<cmd>TmuxNavigatePrevious<cr>")
end)
