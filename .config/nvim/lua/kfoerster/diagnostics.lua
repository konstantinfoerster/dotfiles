vim.diagnostic.config({
  virtual_text = true,
  underline = { severity = vim.diagnostic.severity.ERROR },
  jump = {
    float = true,
  },
  float = {
    severity_sort = true,
    focusable = false,
    source = true,
    header = "",
  },
})
