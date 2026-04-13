return {
  "ibhagwan/fzf-lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },

  config = function()
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
  end,
}
