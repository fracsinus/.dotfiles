local packer = require("packer")

packer.use("EdenEast/nightfox.nvim")

vim.o.cursorline = 1
vim.o.cursorlineopt= "both"

vim.cmd.colorscheme("nightfox")
