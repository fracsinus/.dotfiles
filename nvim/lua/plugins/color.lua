return {
  {
    "folke/tokyonight.nvim",
    opts = {
      style = "moon",
      transparent = true,
      on_highlights = function(hl, _)
        hl.DiagnosticVirtualTextError.bg = nil;
      end,
    },
    config = function (_, opts)
      require("tokyonight").setup(opts)
      require("tokyonight").load()
    end
  }
}
