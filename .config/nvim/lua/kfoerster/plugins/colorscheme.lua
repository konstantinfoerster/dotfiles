return {
  {
    "rose-pine/neovim",
    name = "rose-pine",
    lazy = false,
    priority = 1000,
    config = function()
      require("rose-pine").setup({
        extend_background_behind_borders = false,
        styles = {
          italic = false,
          transparency = false,
        },
        dim_inactive_windows = false,
        palette = {
          -- Override the builtin palette per variant
          moon = {
            base = "#232326",
            surface = "#232326",
          },
        },
        highlight_groups = {
          DiffAdd = { bg = "foam", blend = 10 },
          DiffChange = { bg = "rose", blend = 10 },
          DiffDelete = { bg = "love", blend = 10 },
          DiffText = { bg = "rose", blend = 30 },
        },
      })
      vim.cmd("colorscheme rose-pine-moon")
    end,
  },
}
