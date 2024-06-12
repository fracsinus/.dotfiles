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
  },
  {
    "rmagatti/goto-preview",
    dependencies = { "neovim/nvim-lspconfig" },
    opts = {
      post_open_hook = function(buf, win)
        vim.api.nvim_set_option_value("modifiable", false, { buf = buf })
        vim.keymap.set("n", "q", require("goto-preview").close_all_win, { buffer = buf, noremap = true })
        vim.keymap.set("n", "<BS>", ":q<CR>", { buffer = buf, noremap = true })
      end
    },
    config = function(_, opts)
      local p = require("goto-preview")
      p.setup(opts)
      vim.keymap.set("n", "gd", p.goto_preview_definition, { noremap = true })
      vim.keymap.set("n", "gD", p.goto_preview_declaration, { noremap = true })
      vim.keymap.set("n", "gt", p.goto_preview_type_definition, { noremap = true })
      vim.keymap.set("n", "gi", p.goto_preview_implementation, { noremap = true })
    end
  },
}

for _, v in ipairs(require("plugins.lsp._cmp")) do
  table.insert(M, v)
end

return M
