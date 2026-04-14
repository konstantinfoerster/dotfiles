vim.api.nvim_create_autocmd("UIEnter", {
  once = true,
  callback = vim.schedule_wrap(function()
    vim.pack.add({
      { src = "https://github.com/windwp/nvim-ts-autotag", name = "nvim-ts-autotag" },
    })
    require("nvim-ts-autotag").setup({})
  end),
})
