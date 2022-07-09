local present, treesitter = pcall(require, "nvim-treesitter.configs")

if not present then
  return
end

require("base46").load_highlight "syntax"
require("base46").load_highlight "treesitter"

local options = {
  ensure_installed = {
    "bash",
    "cpp",
    "c",
    "c_sharp",
    "css",
    "dockerfile",
    "graphql",
    "go",
    "html",
    "javascript",
    "java",
    "json",
    "kotlin",
    "lua",
    "markdown",
    "make",
    "python",
    "php",
    "proto",
    "perl",
    "ruby",
    "rust",
    "scss",
    "solidity",
    "typescript",
    "tsx",
    "toml",
    "vim",
    "yaml"
  },
  highlight = {
    enable = true,
    use_languagetree = true,
  },
  indent = {
    enable = true,
  },
  rainbow = {
    enable = true,
    extended_mode = true,
    max_file_lines = nil,
  }
}

-- check for any override
options = require("core.utils").load_override(options, "nvim-treesitter/nvim-treesitter")

treesitter.setup(options)
