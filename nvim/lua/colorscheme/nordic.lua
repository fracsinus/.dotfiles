local packer = require("packer")

packer.use("andersevenrud/nordic.nvim")

local nord_8 = "#5E81AC"
vim.cmd(string.format([[
  augroup nord-theme-overrides
    autocmd!
    autocmd ColorScheme nordic highlight Comment guifg=%s
  augroup end
]], nord_8))
vim.o.cursorline = 1
vim.o.cursorlineopt= "number"
vim.g.nord_cursor_line_number_background = 1

vim.cmd.colorscheme("nordic")
