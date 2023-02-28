local map = vim.api.nvim_set_keymap

-- Ctrl-s to save in both normal and insert mode
map("n", "<C-s>", ":w<CR>", { noremap = true })
map("i", "<C-s>", "<ESC>:w<CR>", { noremap = true })

-- K to remove highlights
map("n", "K", ":noh<CR>", { noremap = true })
-- " Alt+Backspace to remove a previous word
map("i", "<A-BS>", "<C-w>", { noremap = true })

-- " w!! to write as root
map("c", "w!!", "%!sudo tee > /dev/null %", {})
-- cmap w!! %!sudo tee > /dev/null %

-- (Visual) Ctrl+c to copy into clipboard register
map("v", "<C-c>", '"+y', { noremap = true })
