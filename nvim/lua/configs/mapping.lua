local map = vim.api.nvim_set_keymap

-- Ctrl-s to save in both normal and insert mode
if vim.g.vscode then
  vim.keymap.set("n", "<C-s>", function () require("vscode-neovim").call("workbench.action.files.save") end, { noremap = true })
  -- vim.keymap.set("n", "<C-s>", function () print("foobar") end, { noremap = true })
  -- map("n", "<C-s>", ":lua print('foobar')", { noremap = true })
  -- map("i", "<C-s>", "<ESC>:w<CR>", { noremap = true })
else
  map("n", "<C-s>", ":w<CR>", { noremap = true })
  map("i", "<C-s>", "<ESC>:w<CR>", { noremap = true })
end

-- simulate line swapping of VSCode
if not vim.g.vscode then
  map("n", "<A-Up>", ":m .-2<CR>", { noremap = true })
  map("n", "<A-Down>", ":m .+1<CR>", { noremap = true })
  map("v", "<A-Up>", ":m '<-2<CR>gv", { noremap = true })
  map("v", "<A-Down>", ":m '>+1<CR>gv", { noremap = true })
end


-- navigating in insert mode
map("i", "<A-h>", "<Left>", { noremap = true })
map("i", "<A-j>", "<Down>", { noremap = true })
map("i", "<A-k>", "<Up>", { noremap = true })
map("i", "<A-l>", "<Right>", { noremap = true })

-- K to remove highlights
map("n", "K", ":noh<CR>", { noremap = true })
-- " Alt+Backspace to remove a previous word
map("i", "<A-BS>", "<C-w>", { noremap = true })

-- " w!! to write as root
map("c", "w!!", "%!sudo tee > /dev/null %", {})
-- cmap w!! %!sudo tee > /dev/null %

-- (Visual) Ctrl+c to copy into clipboard register
map("v", "<C-c>", '"+y', { noremap = true })

vim.keymap.set("n", "<Leader>q", ":tabc<CR>", { noremap = true })
-- vim.keymap.set("n", "<C-S-PageUp>", ":-tabmove<CR>", { noremap = true })
-- vim.keymap.set("n", "<C-S-PageDown>", ":+tabmove<CR>", { noremap = true })
