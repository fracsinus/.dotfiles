return {
  { "hrsh7th/cmp-nvim-lsp", dependencies = { "neovim/nvim-lspconfig" } },
  {
    -- display function signatures in insert mode
    "hrsh7th/cmp-nvim-lsp-signature-help",
    dependencies = { "neovim/nvim-lspconfig" },
  },
  { "hrsh7th/cmp-path" },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      { "hrsh7th/cmp-buffer" },
      { "hrsh7th/cmp-cmdline" },
      { "hrsh7th/vim-vsnip" },
    },
    config = function (_, _)
      local cmp = require("cmp")
      local opts = {
        snippet = {
          -- REQUIRED - you must specify a snippet engine
          expand = function(args)
            vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
          end,
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-L>s"] = function ()
            if cmp.visible_docs() then
              cmp.close_docs()
            else
              cmp.open_docs()
            end
          end,
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<Tab>"] = cmp.mapping(
            function(fallback)
              if cmp.visible()
                then cmp.confirm({ select = true })
                else fallback()
                end
            end
          ),
        }),
        sources = cmp.config.sources(
          { { name = "nvim_lsp" } },
          { { name = "nvim_lsp_signature_help" } },
          { { name = "buffer" } }
        ),
        experimental = { ghost_text = {} }
      }
      cmp.setup(opts)

      cmp.setup.filetype("gitcommit", {
        sources = cmp.config.sources({
          { name = "cmp_git" }, -- You can specify the `cmp_git` source if you were installed it.
        }, {
          { name = "buffer" },
        })
      })

      -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline({ "/", "?" }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = "buffer" }
        }
      })

      -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = "path" }
        }, {
          { name = "cmdline" }
        })
      })
    end,
  },
}
