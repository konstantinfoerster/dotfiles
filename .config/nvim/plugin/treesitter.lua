vim.api.nvim_create_autocmd("PackChanged", {
  callback = function(ev)
    local name, kind = ev.data.spec.name, ev.data.kind
    if name == "nvim-treesitter" and (kind == "install" or kind == "update") then
      if not ev.data.active then
        vim.cmd.packadd("nvim-treesitter")
      end
      vim.cmd("TSUpdate")
    end
  end,
})

vim.pack.add({
  { src = "https://github.com/nvim-treesitter/nvim-treesitter", name = "nvim-treesitter", version = "main" },
})

vim.schedule(function()
  local parsers = {
    "c",
    "bash",
    "css",
    "dockerfile",
    "diff",
    "go",
    "gomod",
    "gosum",
    "gotmpl",
    "groovy",
    "html",
    "java",
    "javascript",
    "json",
    "lua",
    "markdown",
    "markdown_inline",
    "make",
    "python",
    "toml",
    "typescript",
    "vim",
    "vimdoc",
    "vue",
    "query",
    "xml",
    "yaml",
  }

  require("nvim-treesitter").install(parsers)
end)

-- enable highlighting
vim.api.nvim_create_autocmd("FileType", {
  callback = function()
    -- Enable treesitter highlighting and disable regex syntax
    pcall(vim.treesitter.start)
    -- Enable treesitter-based indentation
    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end,
})
