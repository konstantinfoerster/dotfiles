return {
  -- highlights start and end of e.g. functions, if and so on
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  config = function()
    require("ibl").setup()
  end,
}
