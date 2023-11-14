local base = require("lsp._base")

require("lspconfig").rust_analyzer.setup({
  settings = {
    ["rust-analyzer"] = {
      diagnostics = { enable = true },
    }
  },
  on_attach = base.on_attach_lsp,
  capabilities = base.capabilities,
})
