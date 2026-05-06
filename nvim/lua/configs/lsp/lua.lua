local default = require("configs.lsp._default")

vim.lsp.config.lua_ls = {
  single_file_support = true,
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT",
      },
      workspace = {
        checkThirdParty = false,
        library = vim.api.nvim_get_runtime_file("", true),
      },
    },
  },
  on_attach = default.on_attach_lsp,
  capabilities = default.capabilities,
}

vim.lsp.enable("lua_ls")
