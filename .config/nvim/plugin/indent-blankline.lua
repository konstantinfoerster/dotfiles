vim.schedule(function()
  vim.pack.add({
    -- highlight start and end of e.g. functions, if and so on
    { src = "https://github.com/lukas-reineke/indent-blankline.nvim", name = "indent-blankline.nvim" },
  })

  require("ibl").setup({})
end)
