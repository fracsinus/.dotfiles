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
