local default = require("configs.lsp._default")

require("lspconfig").lua_ls.setup({
  single_file_support = true,
  settings = {
    Lua = { runtime = "LuaJIT" }
  },
  on_attach = default.on_attach_lsp,
  capabilities = default.capabilities,
})
