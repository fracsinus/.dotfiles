local packer = require('packer')

---- languages
packer.use 'leafgarland/typescript-vim' -- typescript
packer.use 'udalov/kotlin-vim' -- kotlin
packer.use 'posva/vim-vue' -- vue

---- treesitter
packer.use({
  'nvim-treesitter/nvim-treesitter',
  run = function()
    local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
  end,
})
