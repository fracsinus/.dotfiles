return {
  {
    "nvim-treesitter/nvim-treesitter",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "asm",
          "bash",
          "c",
          "css",
          "html",
          "javascript",
          "json",
          "lua",
          "python",
          "rust",
          "scss",
          "sql",
          "ssh_config",
          "typescript",
          "vimdoc",
          "vue",
        },
        highlight = { enable = true, },
        additional_vim_regex_highlighting = false,
      })
    end
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
      opts.pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook()
    end
  },
}
