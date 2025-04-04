return {
  {
    "ellisonleao/gruvbox.nvim",
    priority = 1000, -- ensure to load this before all other plugins
    name = "gruvbox",
    config = function()
      require("gruvbox").setup({
        italic = {
          strings = false,
          emphasis = false,
          comments = true,
          operators = false,
          folds = false,
        },
        overrides = {
          DiffAdd = { bg = "#525742" },
          DiffChange = { bg = "#3e4934" },
          DiffText = { bg = "#fabd2f" },
        },
        contrast = "", -- can be "hard", "soft" or empty string
      })
      vim.o.background = "dark"
      vim.cmd("colorscheme gruvbox")
    end,
  },
}
