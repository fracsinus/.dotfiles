local packer = require("packer")

packer.use({
  'nvim-treesitter/nvim-treesitter',
  run = function()
    local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
    ts_update()
  end,
})
packer.use('JoosepAlviste/nvim-ts-context-commentstring')

require('nvim-treesitter.configs').setup {
  ensure_installed = { 'vue' },
  highlight = { enable = true, },
  -- indent = { enable= true },
  context_commentstring = {
    enable = true,
    config = {
      sql = { __default = "/* %s */" }
    },
  },
  additional_vim_regex_highlighting = false,
}
