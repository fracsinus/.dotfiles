-- vim.cmd("syntax off")
require("packer").use('JoosepAlviste/nvim-ts-context-commentstring')
require('nvim-treesitter.configs').setup {
  ensure_installed = { 'vue' },
  -- highlight = {
  --   enable = true,
  -- },
  context_commentstring = {
    enable = true
  },
  additional_vim_regex_highlighting = false,
}

---- SQL
vim.cmd("autocmd FileType sql setlocal commentstring=/*\\ %s\\ */")
vim.cmd("autocmd FileType sql setlocal shiftwidth=2")

---- lua
vim.cmd("autocmd FileType lua setlocal shiftwidth=2")
