vim.schedule(function()
  vim.pack.add({
    { src = "https://github.com/nvim-tree/nvim-web-devicons", name = "nvim-web-devicons" },
    { src = "https://github.com/folke/snacks.nvim", name = "snacks.nvim" },
  })

  require("snacks").setup({
    input = { enabled = true },
    indent = {
      enabled = true,
      animate = {
        enabled = false,
      },
    },
    picker = { enabled = true },
  })
end)
