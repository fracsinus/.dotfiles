local default = require("configs.lsp._default")

vim.lsp.config.lua_ls = {
  single_file_support = true,
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT",
        -- path = {
        --   'lua/?.lua',
        --   'lua/?/init.lua',
        -- },
      },
      diagnostics = { globals = { "vim" } },
      workspace = {
        library = {
          vim.env.VIMRUNTIME,
          vim.fn.stdpath("data") .. "/lazy"
        }
        -- library = vim.list_extend(
        --   vim.api.nvim_get_runtime_file("", true),
        --   { vim.fn.stdpath("data") .. "/lazy" }
        -- )
      },
    },
  },
  on_attach = default.on_attach_lsp,
  capabilities = default.capabilities,
}
vim.lsp.enable("lua_ls")
