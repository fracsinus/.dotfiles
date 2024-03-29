---- nvim-tree advises to disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

local packer = require("packer")
packer.init()
packer.use 'wbthomason/packer.nvim'

require("_base") -- install some base plugins

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
vim.o.cin = true
vim.o.si = true
vim.o.inde = nil
vim.o.autoindent = true
vim.o.smartindent = true

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

---- plugin settings

------ diagnostics list
require("trouble").setup({ mode = "document_diagnostics", use_diagnostic_sign = true })
vim.api.nvim_set_keymap("n", "<C-Q>", ":TroubleToggle<CR>", { noremap = true })

------ statusline customization
require("lualine").setup({
  sections = {
    lualine_c = { { "filename", path = 3 } }
  }
})

---- partials
require("utils")
require("syntax")
require("mapping")
require("explorer")
require("autocomplete")
require("lsp")
require("tabs")
require("colorscheme")
require("_telescope")
require("_fold")
