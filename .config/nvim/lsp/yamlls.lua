return {
  settings = {
    yaml = {
      hover = true,
      completion = true,
      validate = false,
      schemaStore = {
        -- enable = true,
        -- url = "https://www.schemastore.org/api/json/catalog.json",
        enable = false,
        -- Avoid TypeError: Cannot read properties of undefined (reading 'length')
        url = "",
      },
      schemas = {
        ["https://json.schemastore.org/kustomization.json"] = {
          "kustomization.yaml",
          "kustomization.yml",
          "**/kustomization.yaml",
          "**/kustomization.yml",
        },
        ["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = {
          "docker-compose*.yaml",
          "docker-compose*.yml",
        },
        kubernetes = {
          "overlays/**/*.yaml",
          "resources/**/*.yaml",
        },
        -- ["https://raw.githubusercontent.com/yannh/kubernetes-json-schema/refs/heads/master/v1.28.15-standalone-strict/all.json"] = {
        --   "overlays/**/*.yaml",
        --   "resources/**/*.yaml",
        -- },
      },
    },
  },
}
