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
        lualine_b = {
          {
            "branch",
            fmt = function(branch)
              local max = 30
              if branch:len() > max then
                return branch:sub(1, max) .. "..."
              end

              return branch
            end,
          },
          "diff",
          "diagnostics",
        },
        lualine_c = {
          { "filename", path = 1 },
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
        lualine_y = {},
      },
      inactive_sections = {
        lualine_c = {
          { "filename", path = 1 },
        },
      },
    })
  end,
}
