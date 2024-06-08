local default = require("configs.lsp._default")

require("lspconfig").tsserver.setup({
  on_attach = default.on_attach_lsp,
  capabilities = default.capabilities,
})
