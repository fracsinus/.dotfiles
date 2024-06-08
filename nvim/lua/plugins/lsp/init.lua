M = {
  { "neovim/nvim-lspconfig" },
  { "ray-x/lsp_signature.nvim", dependencies = { "neovim/nvim-lspconfig" } },
  {
    "folke/trouble.nvim",
    opts = { mode = "document_diagnostics", use_diagnostic_sign = true },
    config = function(_, opts)
      require("trouble").setup(opts)
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
    end
  }
}

for _, v in ipairs(require("plugins.lsp._cmp")) do
  table.insert(M, v)
end

return M
