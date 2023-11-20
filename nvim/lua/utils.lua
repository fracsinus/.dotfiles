local packer = require('packer')

vim.g.ctrlp_custom_ignore = {
  dir = "node_modules"
}

-- auto pair parentheses, curly braces, etc.
packer.use("windwp/nvim-autopairs")
require("nvim-autopairs").setup({})

---- utilities
-- packer.use 'chrisbra/Recover.vim' -- smarter .swp files recovery
-- packer.use 'justinmk/vim-dirvish' -- use - to initiate path navigator (using arrow keys)
-- packer.use('ctrlpvim/ctrlp.vim') -- use C-p to initiate path finder (using path input)
packer.use('christoomey/vim-tmux-navigator') -- use C-h,j,k,l to navigate across vim and tmux panes
-- packer.use('junegunn/fzf') --
-- packer.use('junegunn/fzf.vim') --
packer.use('nanozuki/tabby.nvim')
packer.use('tpope/vim-eunuch') -- use :Rename and :Delete to rename or to delete a file within vim
packer.use('tpope/vim-repeat') -- use . to repeat action
packer.use('tpope/vim-surround') -- use s to indicate surroundings(e.g. quotation marks or parentheses)

---- comment
packer.use('tpope/vim-commentary') -- use gc~ to turn current line into a comment


---- status line
packer.use('nvim-lualine/lualine.nvim')
require("lualine").setup({
  sections = {
    lualine_c = { { "filename", path = 3 } }
  }
})

