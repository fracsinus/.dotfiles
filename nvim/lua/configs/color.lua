if vim.fn.has('termguicolors') then
  vim.api.nvim_exec2("set termguicolors", {})
end

vim.api.nvim_exec2("highlight Normal guibg=none", {})

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
