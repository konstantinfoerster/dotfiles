return {
  settings = {
    gopls = {
      templateExtensions = { "gohtml", "gotmpl", "tmpl" },
      analyses = {
        nilness = true,
        shadow = true,
        unusedparams = true,
        unusedwrite = true,
        useany = true,
        ST1000 = false, -- missing package comments
      },
      codelenses = {
        generate = true,
        regenerate_cgo = true,
        run_govulncheck = true,
        test = true,
        tidy = true,
        upgrade_dependency = false,
        vendor = true,
      },
      staticcheck = true,
      usePlaceholders = false, -- jump to next placeholder seems broken
      semanticTokens = true,
      completeUnimported = true,
      hints = {
        assignVariableTypes = true,
        compositeLiteralFields = true,
        compositeLiteralTypes = true,
        constantValues = true,
        functionTypeParameters = true,
        parameterNames = true,
        rangeVariableTypes = true,
      },
    },
  },
}
