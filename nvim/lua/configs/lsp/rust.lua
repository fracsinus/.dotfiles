local default = require("configs.lsp._default")

local function on_attach(client, bufnr)
  default.on_attach_lsp(client, bufnr)
  vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
end

vim.lsp.config.rust_analyzer = {
  settings = {
    ["rust-analyzer"] = {
      cargo = { allFeatures = true },
      diagnostics = { enable = true },
    }
  },
  on_attach = on_attach,
  capabilities = default.capabilities,
}
vim.lsp.enable("rust_analyzer")
