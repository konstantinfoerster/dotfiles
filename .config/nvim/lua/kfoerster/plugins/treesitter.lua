return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  lazy = false,
  build = ":TSUpdate",
  config = function()
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

    -- enable highlighting
    vim.api.nvim_create_autocmd("FileType", {
      callback = function()
        -- Enable treesitter highlighting and disable regex syntax
        pcall(vim.treesitter.start)

        -- Enable treesitter-based indentation
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end,
    })
  end,
}
