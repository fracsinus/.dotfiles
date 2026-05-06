local default = require("configs.lsp._default")

---@return string?
local function get_python_path()
  if vim.env.PYENV_VIRTUAL_ENV then
    return table.concat({vim.env.VIRTUAL_ENV, "bin", "python"})
  end

  return nil
end

---@type vim.lsp.Config
local config = {
  single_file_support = true,
  root_markers = {
    'pyrightconfig.json',
    'pyproject.toml',
    'setup.py',
    'setup.cfg',
    'requirements.txt',
    'Pipfile',
    '.git',
  },
  settings = {
    analysis = {
      diagnosticMode = "openFilesOnly",
    }
  },
  on_attach = default.on_attach_lsp,
  capabilities = default.capabilities,
  before_init = function(_, config)
    local python_path = get_python_path()
    if python_path then
      config.settings.python.pythonPath = python_path
    end
  end,
}

vim.lsp.config("pyright", config)
vim.lsp.enable("pyright")
