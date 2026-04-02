return {
  dir = vim.fn.stdpath("config") .. "/lua/plugins/vertical-tabline",
  config = function()
    require("vertical-tabline").setup()
  end,
}
