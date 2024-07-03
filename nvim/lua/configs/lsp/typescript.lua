local default = require("configs.lsp._default")
local util = require("lspconfig/util")

require("lspconfig").tsserver.setup({
  init_options = {
    plugins = {
      {
        name = "@vue/typescript-plugin",
        location = util.path.join(vim.env.FNM_DIR, "aliases", "default", "lib", "node_modules", "@vue", "language-server"),
        languages = { "vue" },
      },
    },
  },
  on_attach = default.on_attach_lsp,
  capabilities = default.capabilities,
  filetypes = { "typescript", "javascript", "vue" }
})
