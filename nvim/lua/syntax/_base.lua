local packer = require("packer")

-- auto pair parentheses, curly braces, etc.
packer.use("jiangmiao/auto-pairs")

packer.use('JoosepAlviste/nvim-ts-context-commentstring')

require('nvim-treesitter.configs').setup {
  ensure_installed = { 'vue' },
  highlight = { enable = true, },
  -- indent = { enable= true },
  context_commentstring = { enable = true },
  additional_vim_regex_highlighting = false,
}
