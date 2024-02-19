return {
  "szw/vim-maximizer",
  init = function()
    vim.g.maximizer_set_default_mapping = 0
    vim.keymap.set("n", "<leader>m", ":MaximizerToggle<CR>")
    vim.keymap.set("v", "<leader>m", ":MaximizerToggle<CR>gv")
  end,
}
