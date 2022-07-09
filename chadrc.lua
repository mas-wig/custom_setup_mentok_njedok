local M = {}
local treestitterConf = require "custom.plugins.configs.treestitter"

M.ui = {
  theme_toggle = { "gatekeeper", "nightowl" },
  override = {

  }
}

M.plugins = {
  user = require "custom.plugins",
  override = {
    ["nvim-treesitter/nvim-treesitter"] = treestitterConf.treesitter,
  },
  options = {
    lspconfig = {
      setup_lspconf = "custom.plugins.configs.lspconfig",
    },
  },
}

return M
