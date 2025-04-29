local default = require("configs.lsp._default")
local config = {
  cmd = { vim.fn.exepath("jdtls") },
  root_dir = vim.fs.root(0, {".git", "mvnw", "gradlew"}) ,
  on_attach = default.on_attach_lsp,
  capabilities = default.capabilities,
}

require("jdtls").start_or_attach(config)
