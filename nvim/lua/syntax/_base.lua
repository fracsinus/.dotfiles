local packer = require("packer")

packer.use({
  'nvim-treesitter/nvim-treesitter',
  run = function()
    local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
    ts_update()
  end,
})

packer.use('JoosepAlviste/nvim-ts-context-commentstring')

vim.g.skip_ts_context_commentstring_module = true
require('ts_context_commentstring').setup({
  languages = {
    sql = { __default = '/* %s */' },
  },
})

require('nvim-treesitter.configs').setup {
  highlight = { enable = true, },
  additional_vim_regex_highlighting = false,
}
