return {
  -- file explorer
  "nvim-tree/nvim-tree.lua",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    -- disable netrw at the very start of your init.lua
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    require("nvim-tree").setup({
      sort_by = "case_sensitive",
      view = {
        width = 30,
      },
      renderer = {
        group_empty = true,
      },
      filters = {
        dotfiles = false,
      },
      git = {
        ignore = false,
      },
      update_focused_file = {
        enable = true,
      },
    })

    vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<CR>") -- toggle file explorer
    vim.keymap.set("n", "<leader>ef", "<cmd>NvimTreeFindFileToggle<CR>") -- toggle file finder
    vim.keymap.set("n", "<leader>ec", "<cmd>NvimTreeCollapse<CR>") -- collapse file explorer
    vim.keymap.set("n", "<leader>er", "<cmd>NvimTreeRefresh<CR>") -- refresh file explorer
  end,
}

