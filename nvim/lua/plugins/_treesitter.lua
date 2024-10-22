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
          "scala",
          "scss",
          "sql",
          "ssh_config",
          "tsx",
          "typescript",
          "vimdoc",
          "vue",
          "yaml",
        },
        highlight = { enable = true },
        indent = {
          enable = true,
          disable = { "yaml" },
        },
        additional_vim_regex_highlighting = false,
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
