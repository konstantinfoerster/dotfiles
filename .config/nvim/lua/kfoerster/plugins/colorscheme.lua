return {
  "navarasu/onedark.nvim",
  priority = 1000, -- ensure to load this before all other plugins
  config = function()
    require("onedark").setup({
      style = "warmer",
    })
    vim.o.background = "dark"
    vim.cmd("colorscheme onedark")
  end,
}
