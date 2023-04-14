local packer = require("packer")

packer.use("arcticicestudio/nord-vim")
packer.use("sainnhe/everforest")

---- enable 24-bit color
if vim.fn.has('termguicolors') then
  vim.api.nvim_exec2("set termguicolors", {})
end

---- Nord
local nord_8 = "#5E81AC"
vim.cmd(string.format([[
  augroup nord-theme-overrides
    autocmd!
    autocmd ColorScheme nord highlight Comment guifg=%s
  augroup end
]], nord_8))
vim.o.cursorline = 1
vim.o.cursorlineopt= "number"
vim.g.nord_cursor_line_number_background = 1

vim.cmd.colorscheme("nord")

---- Everforest
-- vim.o.background = "dark"
-- vim.g.everforest_transparent_background = 2
-- vim.g.everforest_background = "soft"
-- vim.cmd.colorscheme("everforest")

---- Set color of ColorColumn
-- vim.api.nvim_exec("highlight ColorColumn ctermbg=7", true)
-- vim.api.nvim_exec("highlight LineNr ctermbg=7", true)
--
---- transparent background
vim.api.nvim_exec2("highlight Normal guibg=none", {})
-- vim.api.nvim_exec2("highlight NonText guibg=none", {})
-- vim.api.nvim_exec2("highlight ColorColumn guibg=none", {})
-- vim.api.nvim_exec2("highlight LineNr ctermfg=6", {})
--
---- Highlight EOL whitespace, http://vim.wikia.com/wiki/Highlight_unwanted_spaces
vim.cmd [[
if !exists('g:vscode')
  highlight ExtraWhitespace guibg=red
  match ExtraWhitespace /\s\+$/
  autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
  autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
  autocmd InsertLeave * match ExtraWhitespace /\s\+$/
  autocmd BufWinLeave * call clearmatches()
endif
]]

