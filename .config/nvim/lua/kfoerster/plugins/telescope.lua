return {
  -- fuzzy finder
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "nvim-telescope/telescope-file-browser.nvim",
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")
    telescope.setup({
      defaults = {
        path_display = { "truncate" },
        mappings = {
          i = {
            ["<C-k>"] = actions.move_selection_previous, -- move to prev result
            ["<C-j>"] = actions.move_selection_next, -- move to next result
            ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
          },
        },
      },
    })
    telescope.load_extension("fzf")
    telescope.load_extension("file_browser")

    local builtin = require("telescope.builtin")
    vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find files in cwd" })
    vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Find in buffers" })
    vim.keymap.set("n", "<leader>fr", builtin.oldfiles, { desc = "Find recent used files" })
    vim.keymap.set("n", "<leader>fg", builtin.git_files, { desc = "Find files known by git" })
    vim.keymap.set("n", "<leader>sc", builtin.grep_string, { desc = "Find string under cursor" })
    vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "Find string in cwd" })
    vim.keymap.set("n", "<leader>ss", function()
      builtin.grep_string({ search = vim.fn.input("Grep > ") })
    end, { desc = "Find string in cwd" })
    vim.keymap.set(
      "n",
      "<leader>fe",
      "<Cmd>:Telescope file_browser<CR>",
      { desc = "Open file browser", noremap = true }
    )
  end,
}
