return {
  {
    'alvarosevilla95/luatab.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {
      title = function(bufnr)
          local file = vim.fn.bufname(bufnr)
          local buftype = vim.fn.getbufvar(bufnr, '&buftype')
          local filetype = vim.fn.getbufvar(bufnr, '&filetype')

          if buftype == 'help' then
              return 'help:' .. vim.fn.fnamemodify(file, ':t:r')
          elseif buftype == 'quickfix' then
              return 'quickfix'
          elseif filetype == 'TelescopePrompt' then
              return 'Telescope'
          elseif filetype == 'git' then
              return 'Git'
          elseif filetype == 'fugitive' then
              return 'Fugitive'
          elseif filetype == 'NvimTree' then
              return 'NvimTree'
          elseif filetype == 'neo-tree' then
              return 'NeoTree'
          elseif filetype == 'oil' then
              return 'Oil'
          elseif file:sub(file:len()-2, file:len()) == 'FZF' then
              return 'FZF'
          elseif buftype == 'terminal' then
              local _, mtch = string.match(file, "term:(.*):(%a+)")
              return mtch ~= nil and mtch or vim.fn.fnamemodify(vim.env.SHELL, ':t')
          elseif file == '' then
              return '[No Name]'
          else
              return vim.fn.fnamemodify(file, ':p:~:t')
              -- return vim.fn.pathshorten(vim.fn.fnamemodify(file, ':p:~:t'))
          end
      end
    },
  },
  -- {
  --   "nanozuki/tabby.nvim",
  --   lazy = false,
  --   config = function(_, _)
  --     vim.o.showtabline = 2
  --     require("tabby.tabline").use_preset("tab_only", { })

  --     vim.keymap.set("n", "<C-S-PageUp>", "<CMD>-tabmove<CR>", { noremap = true })
  --     vim.keymap.set("n", "<C-S-PageDown>", "<CMD>+tabmove<CR>", { noremap = true })
  --   end
  -- },
  {
    "nvim-lualine/lualine.nvim",
    opts = {
      sections = {
        lualine_c = { { "filename", path = 3 } },
      },
    },
  },
  {
    "windwp/nvim-autopairs",
    event="InsertEnter",
    config = function(_, opts)
      local autopairs = require("nvim-autopairs")
      local cond = require("nvim-autopairs.conds")
      local Rule = require("nvim-autopairs.rule")
      autopairs.setup(opts)
      autopairs.add_rule(Rule('"""', '"""', { "java" }):with_pair(cond.not_before_char('"', 3)))
    end,
  },
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
