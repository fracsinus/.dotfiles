-- vim.keymap.set("n", "<C-S-PageUp>", "<CMD>BufferMovePrevious<CR>", { noremap = true })
-- vim.keymap.set("n", "<C-S-PageDown>", "<CMD>BufferMoveNext<CR>", { noremap = true })

-- require("bufferline").setup({
--   animation = false,
--   clickable = false,
--   closable = false,
--   hide = { hidden = true },
-- })


vim.o.showtabline = 2
require("tabby.tabline").use_preset("tab_only", { })

vim.keymap.set("n", "<C-S-PageUp>", "<CMD>-tabmove<CR>", { noremap = true })
vim.keymap.set("n", "<C-S-PageDown>", "<CMD>+tabmove<CR>", { noremap = true })
