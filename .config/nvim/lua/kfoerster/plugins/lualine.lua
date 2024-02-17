return {
  -- statusline
  "nvim-lualine/lualine.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    local lazy_status = require("lazy.status")

    require("lualine").setup({
      options = {
        globalstatus = false,
        theme = "auto",
      },
      sections = {
        lualine_a = {
          -- show buffers instead of mode
          { "buffers" },
        },
        lualine_x = {
          {
            -- show lazy updates in lualine
            lazy_status.updates,
            cond = lazy_status.has_updates,
            color = { fg = "#ff9e64" },
          },
          { "encoding" },
          { "fileformat" },
          { "filetype" },
        },
      },
    })
  end,
}
