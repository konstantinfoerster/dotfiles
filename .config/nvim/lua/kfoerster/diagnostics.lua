vim.diagnostic.config({
  virtual_text = true,
  severity_sort = true,
  underline = { severity = vim.diagnostic.severity.ERROR },
  jump = {
    float = true,
  },
  float = {
    focusable = false,
    source = true,
    header = "",
  },
})

vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, { desc = "Show line [D]iagnostics" })
