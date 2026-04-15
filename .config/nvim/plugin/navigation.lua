-- disable netrw at the very start
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.pack.add({
  { src = "https://github.com/nvim-tree/nvim-tree.lua", name = "nvim-tree.lua" },
})

local HEIGHT_RATIO = 0.6
local WIDTH_RATIO = 0.5
require("nvim-tree").setup({
  sort_by = "case_sensitive",
  view = {
    float = {
      enable = true,
      open_win_config = function()
        local screen_w = vim.opt.columns:get()
        local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()
        local window_w = screen_w * WIDTH_RATIO
        local window_h = screen_h * HEIGHT_RATIO
        local window_w_int = math.floor(window_w)
        local window_h_int = math.floor(window_h)
        local center_x = (screen_w - window_w) / 2
        local center_y = ((vim.opt.lines:get() - window_h) / 2) - vim.opt.cmdheight:get()
        return {
          border = "rounded",
          relative = "editor",
          row = center_y,
          col = center_x,
          width = window_w_int,
          height = window_h_int,
        }
      end,
    },
    width = function()
      return math.floor(vim.opt.columns:get() * WIDTH_RATIO)
    end,
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = false,
  },
  git = {
    ignore = false,
  },
  update_focused_file = {
    enable = true,
  },
})

vim.keymap.set("n", "<leader>ee", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle [E]xplorer" })
vim.keymap.set("n", "<leader>er", "<cmd>NvimTreeRefresh<CR>", { desc = "[E]xplorer [R]fresh" })

-- fuzzy finder
vim.api.nvim_create_autocmd("UIEnter", {
  once = true,
  callback = vim.schedule_wrap(function()
    vim.pack.add({
      { src = "https://github.com/nvim-tree/nvim-web-devicons", name = "nvim-web-devicons" },
      { src = "https://github.com/ibhagwan/fzf-lua", name = "fzf-lua" },
    })

    local fzf = require("fzf-lua")
    vim.keymap.set("n", "<leader>sf", fzf.files, { desc = "[S]earch [F]iles" })
    vim.keymap.set("n", "<leader>s.", fzf.oldfiles, { desc = "[S]earch recently used files ('.' for repeat)" })
    vim.keymap.set("n", "<leader>sh", fzf.helptags, { desc = "[S]earch [H]elp" })
    vim.keymap.set("n", "<leader>sb", fzf.buffers, { desc = "[S]earch existing [B]uffers" })
    vim.keymap.set("n", "<leader>sw", fzf.grep_cword, { desc = "[S]earch current [W]ord" })
    vim.keymap.set("v", "<leader>sv", fzf.grep_visual, { desc = "[S]earch [V]isual selection" })
    vim.keymap.set("n", "<leader>ss", fzf.live_grep, { desc = "[S]earch [S]tring by grep" })
    vim.keymap.set("n", "<leader>sr", fzf.resume, { desc = "[S]earch [R]esume" })
    vim.keymap.set("n", "<leader>sd", fzf.diagnostics_workspace, { desc = "[S]earch [D]iagnostics" })
    vim.keymap.set("n", "<leader>gs", fzf.git_status, { desc = "[G]it [S]tatus" })
  end),
})
