-- nvim-tree advises to disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require("plugins") -- install plugins

local nvim_exec = vim.api.nvim_exec

nvim_exec("language messages en_US.UTF-8", true) -- set UI language

vim.o.hidden = false

-- file encodings
vim.o.fencs="ucs-bom,utf-8,cp949"

-- color scheme
vim.cmd.colorscheme("nord")

-- search
vim.o.hlsearch = true -- highlight text while searching
vim.o.incsearch = true-- use incremental searching
vim.o.ttimeoutlen = 0 -- remove interval when press esc

-- indentation
vim.bo.tabstop = 2
vim.bo.shiftwidth = 2
vim.bo.softtabstop = 2
vim.bo.expandtab = true
vim.bo.cin = true
vim.bo.si = true
vim.bo.inde = nil
vim.bo.autoindent = true
vim.bo.smartindent = true

-- display line number
vim.wo.nu = true

-- vim.cmd [[
-- set termguicolors
-- set background=light
-- ]]

-- Highlight EOL whitespace, http://vim.wikia.com/wiki/Highlight_unwanted_spaces
vim.cmd [[
if !exists('g:vscode')
  highlight ExtraWhitespace ctermbg=red guibg=red
  match ExtraWhitespace /\s\+$/
  autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
  autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
  autocmd InsertLeave * match ExtraWhitespace /\s\+$/
  autocmd BufWinLeave * call clearmatches()
endif
]]

vim.o.splitright = true
vim.o.splitbelow = true

-- Prevent vim from clearing the terminal
-- vim.t_te = nil
-- vim.t_ti = nil

-- Restore the last editing position
vim.cmd [[
autocmd BufReadPost *
  \ if line("'\"") > 0 && line("'\"") <= line("$") |
  \   exe "normal! g`\"" |
  \ endif
]]

-- Set color of ColorColumn
nvim_exec("highlight ColorColumn ctermbg=7", true)
nvim_exec("highlight LineNr ctermbg=7", true)

-- transparent background
-- nvim_exec("highlight Normal ctermbg=none", true)
-- nvim_exec("highlight NonText ctermbg=none", true)
-- nvim_exec("highlight ColorColumn ctermbg=none", true)
vim.api.nvim_set_hl(0, "LineNr", { ctermbg = nil, ctermfg = 6 })

-- python
-- autocmd FileType python setlocal colorcolumn=80 -- highlight 80th column
vim.g["pyindent_open_paren"] = 'shiftwidth()' -- disable double indentation after a open parenthesis
vim.g["python3_host_prog"] = '/usr/bin/python'

-- set exrc


-- plugin settings

---- diagnostics list
require("trouble").setup({ mode = "document_diagnostics", use_diagnostic_sign = true })
vim.api.nvim_set_keymap("n", "<C-Q>", ":TroubleToggle<CR>", { noremap = true })

---- statusline customization
require("lualine").setup({
  sections = {
    lualine_c = { { "filename", path = 3 } }
  }
})

-- partials
require("syntax")
require("mapping")
require("explorer")
require("autocomplete")
require("lsp")
require("tabs")

