M = {
  { "neovim/nvim-lspconfig" },
  { "ray-x/lsp_signature.nvim", dependencies = { "neovim/nvim-lspconfig" } },
  {
    "folke/trouble.nvim",
    opts = { mode = "document_diagnostics", use_diagnostic_sign = true },
    config = function(_, opts)
      require("trouble").setup(opts)
      vim.api.nvim_set_keymap("n", "<C-Q>", ":Trouble diagnostics toggle<CR>", { noremap = true })
    end
  },
  {
    "rmagatti/goto-preview",
    dependencies = { "neovim/nvim-lspconfig" },
    opts = {
      height = 20,
      post_open_hook = function(buf, win)
        vim.api.nvim_set_option_value("modifiable", false, { buf = buf })
        vim.keymap.set("n", "q", require("goto-preview").close_all_win, { buffer = buf, noremap = true })
        vim.keymap.set("n", "<BS>", ":q<CR>", { buffer = buf, noremap = true })
      end,
      post_close_hook = function(buf, win)
        vim.api.nvim_set_option_value("modifiable", true, { buf = buf })
      end
    },
    config = function(_, opts)
      local p = require("goto-preview")
      p.setup(opts)
      vim.keymap.set("n", "<A-p>d", p.goto_preview_definition, { noremap = true })
      vim.keymap.set("n", "<A-p>D", p.goto_preview_declaration, { noremap = true })
      vim.keymap.set("n", "<A-p>t", p.goto_preview_type_definition, { noremap = true })
      vim.keymap.set("n", "<A-p>i", p.goto_preview_implementation, { noremap = true })
    end
  },
  {
    "scalameta/nvim-metals",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    ft = { "scala", "sbt", "java", "worksheet.sc" },
    opts = function()
      local metals_config = require("metals").bare_config()
      metals_config.on_attach = require("configs.lsp._default").on_attach_lsp

      return metals_config
    end,
    config = function(self, metals_config)
      local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
      vim.api.nvim_create_autocmd(
        "FileType",
        {
          pattern = self.ft,
          callback = function()
            require("metals").initialize_or_attach(metals_config)
          end,
          group = nvim_metals_group
        }
      )
    end,
  }
}

for _, v in ipairs(require("plugins.lsp._cmp")) do
  table.insert(M, v)
end

return M
