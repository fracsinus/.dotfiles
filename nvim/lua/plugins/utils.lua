return {
  {
    "nanozuki/tabby.nvim",
    lazy = false,
    config = function(_, _)
      vim.o.showtabline = 2
      require("tabby.tabline").use_preset("tab_only", { })

      vim.keymap.set("n", "<C-S-PageUp>", "<CMD>-tabmove<CR>", { noremap = true })
      vim.keymap.set("n", "<C-S-PageDown>", "<CMD>+tabmove<CR>", { noremap = true })
    end
  },
  {
    "nvim-lualine/lualine.nvim",
    opts = {
      sections = {
        lualine_c = { { "filename", path = 3 } },
      },
    },
  },
  { "windwp/nvim-autopairs", event="InsertEnter", config = true },
  { "christoomey/vim-tmux-navigator" }, -- use C-h,j,k,l to navigate across vim and tmux panes
  { "tpope/vim-eunuch" }, -- use :Rename and :Delete to rename or to delete a file within vim
  { "tpope/vim-repeat" }, -- use . to repeat action
  { "tpope/vim-surround" }, -- use s to indicate surroundings(e.g. quotation marks or parentheses)
  {
    "kevinhwang91/nvim-ufo",
    dependencies = { "kevinhwang91/promise-async" },
    config = function()
      local ufo = require("ufo")
      -- vim.o.foldcolumn = "0" -- "0" is not bad
      vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true

      -- Using ufo provider need remap `zR` and `zM`. If Neovim is 0.6.1, remap yourself
      vim.keymap.set("n", "zR", ufo.openAllFolds)
      vim.keymap.set("n", "zM", ufo.closeAllFolds)
      vim.keymap.set("n", "<leader>x", function() ufo.getFolds(0, "treesitter") end)
      vim.keymap.set("n", "zK", function()
          local winid = ufo.peekFoldedLinesUnderCursor()
          if not winid then
              vim.lsp.buf.hover()
          end
      end)
      vim.keymap.set("n", "<A-]>", "zj", { noremap = true })
      vim.keymap.set("n", "<A-[>", "zk", { noremap = true })

      vim.env.UFO_LOG = "error"
      ufo.setup({
          provider_selector = function(bufnr, filetype, buftype)
              return {"treesitter", "indent"}
          end
      })
    end,
  },
}
