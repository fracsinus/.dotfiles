-- Only required if you have packer configured as `opt`
-- vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'

  ---- color schemes
  use 'arcticicestudio/nord-vim'
  -- use 'altercation/vim-colors-solarized'

  ---- utilities
  -- use 'chrisbra/Recover.vim' -- smarter .swp files recovery
  -- use 'justinmk/vim-dirvish' -- use - to initiate path navigator (using arrow keys)
  use 'christoomey/vim-tmux-navigator' -- use C-h,j,k,l to navigate across vim and tmux panes
  use 'ctrlpvim/ctrlp.vim' -- use C-p to initiate path finder (using path input)
  use 'junegunn/fzf' --
  use 'junegunn/fzf.vim' --
  use 'nanozuki/tabby.nvim'
  use 'nvim-tree/nvim-tree.lua'
  use 'nvim-tree/nvim-web-devicons'
  use 'tpope/vim-eunuch' -- use :Rename and :Delete to rename or to delete a file within vim
  use 'tpope/vim-repeat' -- use . to repeat action
  use 'tpope/vim-surround' -- use s to indicate surroundings(e.g. quotation marks or parentheses)

  ------ comment
  use 'tpope/vim-commentary' -- use gc~ to turn current line into a comment
  use {
    'nvim-treesitter/nvim-treesitter',
    run = function()
        local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
        ts_update()
    end,
  }
  use 'JoosepAlviste/nvim-ts-context-commentstring'

  ---- languages
  use 'leafgarland/typescript-vim' -- typescript
  use 'udalov/kotlin-vim' -- kotlin
  use 'posva/vim-vue' -- vue

  ---- LSP plugins
  ------ convenience layer
  use 'neovim/nvim-lspconfig'

  ------ autocompletion
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/cmp-nvim-lsp-signature-help'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/vim-vsnip'

  use 'ray-x/lsp_signature.nvim'

  ------ diagnostic in separate list view
  use 'folke/trouble.nvim'
  -- use 'kyazdani42/nvim-web-devicons'

  ---- status line
  use 'nvim-lualine/lualine.nvim'
end)

