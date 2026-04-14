return {
  before_init = function(_, config)
    local vuePluginConfig = {
      name = "@vue/typescript-plugin",
      location = vim.fn.expand("$MASON/packages/vue-language-server/node_modules/@vue/language-server"),
      languages = { "vue" },
      configNamespace = "typescript",
      enableForWorkspaceTypeScriptVersions = true,
    }
    table.insert(config.settings.vtsls.tsserver.globalPlugins, vuePluginConfig)
  end,
  filetypes = {
    "javascript",
    "javascriptreact",
    "javascript.jsx",
    "typescript",
    "typescriptreact",
    "typescript.tsx",
    "vue",
  },
  settings = {
    complete_function_calls = true,
    vtsls = {
      tsserver = {
        globalPlugins = {},
      },
      enableMoveToFileCodeAction = true,
      autoUseWorkspaceTsdk = true,
      experimental = {
        completion = {
          enableServerSideFuzzyMatch = true,
        },
      },
    },
    typescript = {
      updateImportsOnFileMove = { enabled = "always" },
      suggest = {
        completeFunctionCalls = true,
      },
    },
  },
}
