local default = require("configs.lsp._default")

vim.lsp.config.lua_ls = {
  single_file_support = true,
  settings = {
    Lua = { runtime = "LuaJIT" }
  },
  on_attach = default.on_attach_lsp,
  capabilities = default.capabilities,
}
vim.lsp.enable("lua_ls")
