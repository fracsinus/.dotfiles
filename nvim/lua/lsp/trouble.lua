-- diagnostics list
--
require("packer").use("folke/trouble.nvim")
require("trouble").setup({ mode = "document_diagnostics", use_diagnostic_sign = true })

vim.api.nvim_set_keymap("n", "<C-Q>", ":Trouble diagnostics toggle<CR>", { noremap = true })

local virtual_text = true
vim.keymap.set(
  "n",
  "+",
  function()
    virtual_text = not virtual_text
    vim.diagnostic.config({virtual_text = virtual_text})
  end,
  { noremap = true }
)

