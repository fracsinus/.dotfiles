local default = require("configs.lsp._default")
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
  on_attach = default.on_attach_lsp,
  capabilities = default.capabilities,
  before_init = function(_, config)
    config.settings.python.pythonPath = get_python_path()
  end,
})

