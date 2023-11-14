local base = require("lsp._base")

require("lspconfig").tsserver.setup({
  on_attach = base.on_attach_lsp,
  capabilities = base.capabilities,
})
