local packer = require("packer")

packer.use("folke/tokyonight.nvim")

vim.o.cursorline = 1
vim.o.cursorlineopt= "both"

require("tokyonight").setup({
  transparent = true,
  on_highlights = function(hl, c)
    hl.DiagnosticVirtualTextError.bg = nil;
  end,
})

vim.cmd.colorscheme("tokyonight-moon")
