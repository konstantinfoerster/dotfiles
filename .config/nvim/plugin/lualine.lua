vim.api.nvim_create_autocmd("BufEnter", {
  once = true,
  callback = vim.schedule_wrap(function()
    vim.pack.add({
      { src = "https://github.com/nvim-tree/nvim-web-devicons", name = "nvim-web-devicons" },
      { src = "https://github.com/nvim-lualine/lualine.nvim", name = "lualine.nvim" },
    })

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
        lualine_y = {},
      },
      inactive_sections = {
        lualine_c = {
          { "filename", path = 1 },
        },
      },
    })
  end),
})
