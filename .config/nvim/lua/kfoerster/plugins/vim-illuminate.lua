return {
  -- highlighting other uses of the word under the cursor
  "RRethy/vim-illuminate",
  lazy = false,
  config = function()
    require("illuminate").configure({})
  end,
}