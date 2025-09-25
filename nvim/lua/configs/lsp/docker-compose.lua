local default = require("configs.lsp._default")

vim.api.nvim_create_autocmd(
  { "BufRead", "BufNewFile" },
  { pattern = { "docker-compose.yaml", "docker-compose.yml" }, command = "set filetype=yaml.docker-compose"}
)

vim.lsp.config.docker_compose_language_service = {
  on_attach = default.on_attach_lsp,
  capabilities = default.capabilities,
}
vim.lsp.enable("docker_compose_language_service")
