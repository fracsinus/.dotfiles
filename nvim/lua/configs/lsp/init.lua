vim.diagnostic.config({
  virtual_text = {
    severity = nil,
  },
  signs = false,
  update_in_insert = true,
})

require("configs.lsp.dartls")
require("configs.lsp.docker-compose")
require("configs.lsp.dockerfile")
require("configs.lsp.lua")
require("configs.lsp.pyright")
require("configs.lsp.rust")
require("configs.lsp.typescript")
require("configs.lsp.volar")
