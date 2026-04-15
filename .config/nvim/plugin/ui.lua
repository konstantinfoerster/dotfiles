vim.schedule(function()
  vim.pack.add({
    -- realtime color highlighting
    { src = "https://github.com/brenoprata10/nvim-highlight-colors", name = "nvim-highlight-colors" },
    -- highlighting other uses of the word under the cursor
    { src = "https://github.com/RRethy/vim-illuminate", name = "vim-illuminate" },
    -- better input and selection picker
    -- show indent guides
    { src = "https://github.com/folke/snacks.nvim", name = "snacks.nvim" },
  })

  require("nvim-highlight-colors").setup({})

  require("illuminate").configure({})

  require("snacks").setup({
    input = { enabled = true },
    indent = {
      enabled = true,
      animate = {
        enabled = false,
      },
    },
    picker = { enabled = true },
  })
end)

vim.api.nvim_create_autocmd("BufRead", {
  once = true,
  callback = vim.schedule_wrap(function()
    -- highlight and search for todo comments
    vim.pack.add({
      { src = "https://github.com/nvim-lua/plenary.nvim", name = "plenary.nvim" },
      { src = "https://github.com/folke/todo-comments.nvim", name = "todo-comments.nvim" },
    })

    require("todo-comments").setup({
      signs = false,
    })

    vim.keymap.set("n", "<leader>tc", "<Cmd>TodoTrouble<CR>", { desc = "[T]rouble [C]omments" })
  end),
})

vim.api.nvim_create_autocmd("BufEnter", {
  once = true,
  callback = vim.schedule_wrap(function()
    -- better statusline
    vim.pack.add({
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
