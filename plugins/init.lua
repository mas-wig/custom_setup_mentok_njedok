return {
  -- Golang
  ["fatih/vim-go"] = {},

  -- Paranthesis
  ["p00f/nvim-ts-rainbow"] = {},

  -- Database
  ["tpope/vim-dadbod"] = {},
  ["kristijanhusak/vim-dadbod-ui"] = {},

  -- Formatter
  ["lukas-reineke/lsp-format.nvim"] = {},

  -- Trouble
  ["folke/trouble.nvim"] = {
    requires = "kyazdani42/nvim-web-devicons",
    config = function()
      require("trouble").setup {
        mode = "workspace_diagnostics",
        position = "bottom", -- position of the list can be: bottom, top, left, right
        group = true,
        icons = true,
        indent_lines = true,
        auto_open = true,
        auto_close = true,
        auto_preview = true,
        auto_fold = false,
        auto_jump = { "lsp_definitions" },
        signs = {
          error = "",
          warning = "",
          hint = "",
          information = "",
          other = "﫠"
        },
        use_diagnostic_signs = false
      }
    end
  },

  -- Dasboard
  ["goolord/alpha-nvim"] = {
    disable = false,
  },
}
