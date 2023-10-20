local packer = require("packer")
packer.use({"nvim-telescope/telescope-fzf-native.nvim", run = "make" })
packer.use({
  "nvim-telescope/telescope.nvim", tag = "0.1.4",
  requires = { {"nvim-lua/plenary.nvim"} }
})
packer.use({
    "nvim-telescope/telescope-file-browser.nvim",
    requires = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" }
})

local telescope = require("telescope")
local actions = require("telescope.actions")
telescope.setup({
  defaults = {
    mappings = {
      i = {
        ["<C-d>"] = actions.delete_buffer,
      }
    }
  },
  extensions = {
    file_browser = {
      mappings = {
        ["i"] = {
          ["<CR>"] = actions.select_tab,
          ["<C-o>"] = actions.file_edit,
          ["<Tab>"] = actions.toggle_selection,
          ["/"] = false,
          -- ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
          -- ["<S-Tab>"] = actions.toggle_selection,
          -- ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_worse,
          -- ["<M-Tab>"] = actions.toggle_selection + actions.move_selection_better,
          -- ["<M-Tab>"] = actions.toggle_selection,

        },
        ["n"] = {
          ["<CR>"] = actions.select_tab,
          ["<o>"] = actions.file_edit,
        }
      },
      auto_depth = true,
    }
  }
})
telescope.load_extension("fzf")
telescope.load_extension("file_browser")

local builtin = require("telescope.builtin")
-- vim.keymap.set("n", "<C-p>", builtin.find_files, {})
vim.keymap.set("n", "<C-p>", ":Telescope file_browser<CR>", { noremap = true })
vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
vim.keymap.set("n", "<leader>]", builtin.buffers, {})
vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})
