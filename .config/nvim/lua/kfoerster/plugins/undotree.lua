return {
  -- visualizes and browse the undo history
  "mbbill/undotree",
  event = "VeryLazy",
  keys = {
    { "<leader>u", "<cmd>UndotreeToggle<CR>" },
  },
}
