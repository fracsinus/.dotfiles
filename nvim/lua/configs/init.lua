local nvim_exec = vim.api.nvim_exec

nvim_exec("language messages en_US.UTF-8", true) -- set UI language

vim.o.hidden = false

---- file encodings
vim.o.fencs="ucs-bom,utf-8,cp949"

---- search
vim.o.hlsearch = true -- highlight text while searching
vim.o.incsearch = true-- use incremental searching
vim.o.ttimeoutlen = 0 -- remove interval when press esc

---- indentation
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.softtabstop = 2
vim.o.expandtab = true -- insert spaces instead of tab in insert mode
vim.o.inde = nil
vim.o.autoindent = true

---- display line number
vim.wo.nu = true
vim.wo.relativenumber = true

vim.o.splitright = true
vim.o.splitbelow = true

---- Prevent vim from clearing the terminal
-- vim.t_te = nil
-- vim.t_ti = nil

---- Restore the last editing position
vim.cmd [[
autocmd BufReadPost *
  \ if line("'\"") > 0 && line("'\"") <= line("$") |
  \   exe "normal! g`\"" |
  \ endif
]]

-- manually setting python executable path to make startup faster
vim.g["python3_host_prog"] = '/usr/bin/python'

require("configs.lsp")
require("configs.color")
require("configs.mapping")
require("configs.syntax")
