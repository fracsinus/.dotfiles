return {
  {
    "nvim-treesitter/nvim-treesitter",
    config = function()
      -- Filetypes where treesitter indent has issues (JSX/TSX)
      local exclude_indent = { "typescriptreact", "javascriptreact" }

      vim.api.nvim_create_autocmd('FileType', {
        pattern = vim.tbl_deep_extend(
          "force",
          require('nvim-treesitter').get_installed(),
          { "sh", "typescriptreact", }
        ),
        callback = function()
          vim.treesitter.start()
          -- Skip treesitter indent for problematic filetypes
          if not vim.tbl_contains(exclude_indent, vim.bo.filetype) then
            vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
          end
        end,
      })
    end
  },
  {
    "windwp/nvim-ts-autotag",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      require("nvim-ts-autotag").setup({})
    end,
  },
  {
    "JoosepAlviste/nvim-ts-context-commentstring",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    opts = {
      enable_autocmd = false,
      languages = {
        sql = { __default = "/* %s */" },
        asm = { __default = "# %s" },
      },
    }
  },
  {
    "numToStr/Comment.nvim",
    dependencies = { "JoosepAlviste/nvim-ts-context-commentstring" },
    opts = function(_, opts)
      opts.ignore = "^$"
      opts.pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook()
    end
  },
}
