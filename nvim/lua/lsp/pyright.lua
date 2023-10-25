local base = require("lsp._base")
local util = require("lspconfig/util")

local function get_python_path()
  if vim.env.VIRTUAL_ENV then
    return util.path.join(vim.env.VIRTUAL_ENV, "bin", "python")
  end

  return vim.fn.exepath("python")
end

require("lspconfig").pyright.setup({
  single_file_support = true,
  settings = {
    analysis = {
      diagnosticMode = "openFilesOnly",
    }
  },
  on_attach = base.on_attach_lsp,
  capabilities = base.capabilities,
  before_init = function(_, config)
    config.settings.python.pythonPath = get_python_path()
  end,
})

-- local M = {
--   _diagnostic_options = {
--     virtual_text = true,
--   },
-- }

-- M.toggle_virtual_text = function()
--   M._diagnostic_options.virtual_text = not M._diagnostic_options.virtual_text
--   -- print(type(vim.lsp.diagnostic.on_publish_diagnostics))
--   vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
--     vim.lsp.diagnostic.on_publish_diagnostics,
--     M._diagnostic_options
--   )
-- end

-- return M
