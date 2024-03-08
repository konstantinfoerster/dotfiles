return {
  "navarasu/onedark.nvim",
  priority = 1000, -- ensure to load this before all other plugins
  config = function()
    require("onedark").setup({
      style = "warmer",
    })
    vim.o.background = "dark"
    vim.cmd("colorscheme onedark")

    -- some go stuff (boolean, constants) has wrong highlighting, so we fallback to default highlighting by
    -- disabling some overwrites
    vim.api.nvim_set_hl(0, "@lsp.typemod.variable.readonly.go", {})
    vim.api.nvim_set_hl(0, "@lsp.mod.readonly.go", {})
    vim.api.nvim_set_hl(0, "@lsp.type.variable.go", {})
  end,
}
