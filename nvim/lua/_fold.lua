local packer = require("packer")

packer.use({"kevinhwang91/nvim-ufo", requires = "kevinhwang91/promise-async"})
local ufo = require("ufo")

vim.o.foldcolumn = "1" -- "0" is not bad
vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true

-- Using ufo provider need remap `zR` and `zM`. If Neovim is 0.6.1, remap yourself
vim.keymap.set("n", "zR", ufo.openAllFolds)
vim.keymap.set("n", "zM", ufo.closeAllFolds)
vim.keymap.set("n", "<leader>x", function() ufo.getFolds(0, 'treesitter') end)
vim.keymap.set('n', 'zK', function()
    local winid = require('ufo').peekFoldedLinesUnderCursor()
    if not winid then
        vim.lsp.buf.hover()
    end
end)

vim.env.UFO_LOG = 'error'
ufo.setup({
    provider_selector = function(bufnr, filetype, buftype)
        return {"treesitter", "indent"}
    end
})
-- ufo.setup()
