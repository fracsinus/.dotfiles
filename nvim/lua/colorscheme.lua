local packer = require("packer")

if not vim.g.vscode then
  require("colorscheme.nordic")
  ---- enable 24-bit color
  if vim.fn.has('termguicolors') then
    vim.api.nvim_exec2("set termguicolors", {})
  end

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
    highlight ExtraWhitespace ctermbg=red guibg=red
    match ExtraWhitespace /\s\+$/
    autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
    autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
    autocmd InsertLeave * match ExtraWhitespace /\s\+$/
    autocmd BufWinLeave * call clearmatches()
  endif
  ]]

else
  require("colorscheme._vscode")
end
