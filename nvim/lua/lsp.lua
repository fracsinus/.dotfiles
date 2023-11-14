local packer = require("packer")

---- convenience layer
packer.use "neovim/nvim-lspconfig"

---- autocompletion
packer.use "hrsh7th/cmp-buffer"
packer.use "hrsh7th/cmp-cmdline"
packer.use "hrsh7th/cmp-nvim-lsp-signature-help"
packer.use "hrsh7th/cmp-nvim-lsp"
packer.use "hrsh7th/cmp-path"
packer.use "hrsh7th/nvim-cmp"
packer.use "hrsh7th/vim-vsnip"

packer.use "ray-x/lsp_signature.nvim"

require("lsp.pyright")
require("lsp.lua")
require("lsp.rust")
require("lsp.typescript")

require("lsp_signature").setup({})

vim.diagnostic.config({
  virtual_text = true,
  signs = false,
  update_in_insert = true,
})

require("lsp.cmp")

-- diagnostics list
require("lsp.trouble")
