vim.o.background = "dark"

return {
  {
    "folke/tokyonight.nvim",
    opts = {
      style = "moon",
      transparent = true,
      on_highlights = function(hl, _)
        hl.DiagnosticVirtualTextError.bg = nil;
      end,
      on_colors = function(colors)
        colors.fg_gutter = "#747a8f" -- line numbers
        colors.comment = "#7b84b0" -- comments
        colors.terminal_black = "#6d759c" -- DiagnosticUnnecessary (highlight group)
      end,
    },
    config = function (_, opts)
      require("tokyonight").setup(opts)
      require("tokyonight").load()
    end
  }
}
