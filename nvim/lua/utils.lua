local packer = require('packer')

---- utilities
-- packer.use 'chrisbra/Recover.vim' -- smarter .swp files recovery
-- packer.use 'justinmk/vim-dirvish' -- use - to initiate path navigator (using arrow keys)
packer.use 'christoomey/vim-tmux-navigator' -- use C-h,j,k,l to navigate across vim and tmux panes
packer.use 'ctrlpvim/ctrlp.vim' -- use C-p to initiate path finder (using path input)
packer.use 'junegunn/fzf' --
packer.use 'junegunn/fzf.vim' --
packer.use 'nanozuki/tabby.nvim'
packer.use 'tpope/vim-eunuch' -- use :Rename and :Delete to rename or to delete a file within vim
packer.use 'tpope/vim-repeat' -- use . to repeat action
packer.use 'tpope/vim-surround' -- use s to indicate surroundings(e.g. quotation marks or parentheses)

---- comment
packer.use 'tpope/vim-commentary' -- use gc~ to turn current line into a comment
packer.use {
'nvim-treesitter/nvim-treesitter',
run = function()
local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
ts_update()
end,
}
packer.use 'JoosepAlviste/nvim-ts-context-commentstring'

---- status line
packer.use 'nvim-lualine/lualine.nvim'
