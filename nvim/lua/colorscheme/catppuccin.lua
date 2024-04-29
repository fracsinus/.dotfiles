local packer = require("packer")

packer.use({ "catppuccin/nvim", as = "catppuccin" })

vim.o.cursorline = 1
vim.o.cursorlineopt= "both"

require("catppuccin").setup({
  flavour = "mocha",
})
vim.cmd.colorscheme("catppuccin")
