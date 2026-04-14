vim.pack.add({
  { src = "https://github.com/nvim-tree/nvim-web-devicons", name = "nvim-web-devicons" },
  { src = "https://github.com/folke/snacks.nvim", name = "snacks.nvim" },
})

require("snacks").setup({
  input = { enabled = true },
  picker = { enabled = true },
})
