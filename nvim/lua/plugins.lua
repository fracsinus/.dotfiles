local Plug = vim.fn["plug#"]
vim.call("plug#begin", "~/.vim/plugged")

-- General
---- color schemes
-- Plug 'altercation/vim-colors-solarized'
Plug 'arcticicestudio/nord-vim'

---- utilities
-- Plug 'chrisbra/Recover.vim' -- smarter .swp files recovery
Plug 'christoomey/vim-tmux-navigator' -- use C-h,j,k,l to navigate across vim and tmux panes
Plug 'junegunn/fzf.vim' --
-- Plug 'justinmk/vim-dirvish' -- use - to initiate path navigator (using arrow keys)
Plug 'kien/ctrlp.vim' -- use C-p to initiate path finder (using path input)
Plug 'tpope/vim-commentary' -- use gc~ to turn current line into a comment
Plug 'tpope/vim-eunuch' -- use :Rename and :Delete to rename or to delete a file within vim
Plug 'tpope/vim-repeat' -- use . to repeat action
Plug 'tpope/vim-surround' -- use s to indicate surroundings(e.g. quotation marks or parentheses)

Plug 'nvim-tree/nvim-tree.lua'
Plug 'nvim-tree/nvim-web-devicons'

---- languages
Plug 'leafgarland/typescript-vim' -- typescript
Plug 'udalov/kotlin-vim'

---- LSP plugins
------ convenience layer
Plug 'neovim/nvim-lspconfig'

------ autocompletion
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/cmp-nvim-lsp-signature-help'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/nvim-cmp'

Plug 'ray-x/lsp_signature.nvim'

------ diagnostic in separate list view
Plug 'folke/trouble.nvim'
-- Plug 'kyazdani42/nvim-web-devicons'

---- status line
Plug 'nvim-lualine/lualine.nvim'

vim.call("plug#end")
