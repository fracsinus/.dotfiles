local default = require("configs.lsp._default")

vim.lsp.config.dockerls = {
  on_attach = default.on_attach_lsp,
  capabilities = default.capabilities,
}
vim.lsp.enable("dockerls")
