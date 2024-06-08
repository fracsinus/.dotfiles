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
  { "windwp/nvim-autopairs" },
  { "windwp/nvim-ts-autotag" },
  { "christoomey/vim-tmux-navigator" }, -- use C-h,j,k,l to navigate across vim and tmux panes
  { "tpope/vim-eunuch" }, -- use :Rename and :Delete to rename or to delete a file within vim
  { "tpope/vim-repeat" }, -- use . to repeat action
  { "tpope/vim-surround" }, -- use s to indicate surroundings(e.g. quotation marks or parentheses)
}
