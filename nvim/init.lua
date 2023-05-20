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
vim.bo.tabstop = 2
vim.bo.shiftwidth = 2
vim.bo.softtabstop = 2
vim.bo.expandtab = true
vim.bo.cin = true
vim.bo.si = true
vim.bo.inde = nil
vim.bo.autoindent = true
vim.bo.smartindent = true

---- display line number
vim.wo.nu = true

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

---- python
-- autocmd FileType python setlocal colorcolumn=80 -- highlight 80th column
vim.g["pyindent_open_paren"] = 'shiftwidth()' -- disable double indentation after a open parenthesis
vim.g["python3_host_prog"] = '/usr/bin/python'

-- set exrc


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
require("color")
require("_telescope")
require("_fold")
