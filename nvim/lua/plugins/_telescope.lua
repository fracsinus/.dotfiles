return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        -- build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cd build && make',
        build = 'make',
      },
    },
    config = function(_, _)
      local telescope = require("telescope")
      local actions = require("telescope.actions")
      local opts = {
        pickers = {
          buffers = {
            mappings = {
              ["i"] = {
                ["<CR>"] = actions.select_tab,
                ["<C-o>"] = actions.file_edit,
                ["<C-d>"] = actions.delete_buffer,
              },
              ["n"] = {
                ["<CR>"] = actions.select_tab,
                ["<C-o>"] = actions.file_edit,
              },
            },
          },
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
      }
      telescope.setup(opts)
      telescope.load_extension("fzf")
      telescope.load_extension("file_browser")

      local builtin = require("telescope.builtin")
      -- vim.keymap.set("n", "<C-p>", builtin.find_files, {})
      vim.keymap.set("n", "<C-p>", ":Telescope file_browser<CR>", { noremap = true })
      vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
      vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
      vim.keymap.set("n", "<leader>]", builtin.buffers, {})
      vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})
    end,
  },
  { "nvim-telescope/telescope-file-browser.nvim", dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" } },
}
