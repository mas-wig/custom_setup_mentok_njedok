local present, lspconfig = pcall(require, "lspconfig")

if not present then
  return
end

require("base46").load_highlight "lsp"

local M = {}
local utils = require "core.utils"

require "ui.lsp"

M.on_attach = function(client, bufnr)
  client.resolved_capabilities.document_formatting = true
  client.resolved_capabilities.document_range_formatting = true

  local lsp_mappings = utils.load_config().mappings.lspconfig
  utils.load_mappings({ lsp_mappings }, { buffer = bufnr })

  if client.server_capabilities.signatureHelpProvider then
    require("nvchad.ui.signature").setup(client)
  end
end

local capabilities = vim.lsp.protocol.make_client_capabilities()

capabilities.textDocument.completion.completionItem = {
  documentationFormat = { "markdown", "plaintext" },
  snippetSupport = true,
  preselectSupport = true,
  insertReplaceSupport = true,
  labelDetailsSupport = true,
  deprecatedSupport = true,
  commitCharactersSupport = true,
  tagSupport = { valueSet = { 1 } },
  resolveSupport = {
    properties = {
      "documentation",
      "detail",
      "additionalTextEdits",
    },
  },
}

------------------------------------------------------------------
------------------------------------------------------------------

lspconfig.sumneko_lua.setup {
  on_attach = M.on_attach,
  capabilities = capabilities,

  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        library = {
          [vim.fn.expand "$VIMRUNTIME/lua"] = true,
          [vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true,
        },
        maxPreload = 100000,
        preloadFileSize = 10000,
      },
    },
  },
}

-- Golang
lspconfig.gopls.setup {
  on_attach = M.on_attach,
  capabilities = capabilities,

  cmd = { "gopls" },
  filetypes = { "go", "gomod", "gotmpl" },
  single_file_support = true
}

-- HTML
lspconfig.html.setup {
  on_attach = M.on_attach,
  capabilities = capabilities,

  cmd = { "vscode-html-language-server", "--stdio" },
  filetypes = { "html" },
  init_options = {
    configurationSection = { "html", "css", "javascript" },
    embeddedLanguages = {
      css = true,
      javascript = true,
    },
    provideFormatter = true
  },
  single_file_support = true,
}

-- Python
lspconfig.pyright.setup {
  on_attach = M.on_attach,
  capabilities = capabilities,

  cmd = { "pyright-langserver", "--stdio" },
  filetypes = { "python" },
  settings = {
    python = {
      analysis = {
        autoSearchPaths = true,
        diagnosticMode = "workspace",
        useLibraryCodeForTypes = true
      },
    },
  },
  single_file_support = true
}

-- C, Cpp
lspconfig.clangd.setup {
  on_attach = M.on_attach,
  capabilities = capabilities,

  cmd = { "clangd" },
  filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
  single_file_support = true
}

-- Js , Ts , jsx, tsx
lspconfig.tsserver.setup {
  on_attach = M.on_attach,
  capabilities = capabilities,

  cmd                 = { "typescript-language-server", "--stdio" },
  filetypes           = {
    "javascript",
    "javascriptreact",
    "javascript.jsx",
    "typescript",
    "typescriptreact",
    "typescript.tsx",
    "vue"
  },
  init_options        = {
    hostInfo = "neovim"
  },
  single_file_support = true
}

-- Tailwinds
lspconfig.tailwindcss.setup {
  cmd = { "tailwindcss-language-server", "--stdio" },
  filetypes = {
    "aspnetcorerazor",
    "astro",
    "astro-markdown",
    "blade",
    "django-html",
    "htmldjango",
    "edge",
    "eelixir",
    "ejs",
    "erb",
    "eruby",
    "gohtml",
    "haml",
    "tmpl",
    "handlebars",
    "hbs",
    "html-eex",
    "heex",
    "jade",
    "leaf",
    "liquid",
    "markdown",
    "mdx",
    "mustache",
    "njk",
    "nunjucks",
    "razor",
    "slim",
    "twig",
    "css",
    "less",
    "postcss",
    "sass",
    "scss",
    "stylus",
    "sugarss",
    "reason",
    "rescript",
    "vue",
    "svelte"
  },
  settings = {
    tailwindCSS = {
      classAttributes = { "class", "className", "classList", "ngClass" },
      lint = {
        cssConflict = "warning",
        invalidApply = "error",
        invalidConfigPath = "error",
        invalidScreen = "error",
        invalidTailwindDirective = "error",
        invalidVariant = "error",
        recommendedVariantOrder = "warning"
      },
      validate = true
    }
  },
  init_options = {
    userLanguages = {
      eelixir = "html-eex",
      eruby = "erb"
    }
  },
  single_file_support = true,
}

-- SQL
lspconfig.sqls.setup {
  on_attach = M.on_attach,
  capabilities = capabilities,

  cmd = { "sqls" },
  filetypes = { "sql", "mysql" },
  single_file_support = true,
}

-- Rust
lspconfig.rust_analyzer.setup {
  on_attach = M.on_attach,
  capabilities = capabilities,

  cmd = { "rust-analyzer" },
  filetypes = { "rust" },
  settings = {
    ["rust-analyzer"] = {
      assist = {
        importGranularity = "module",
        importPrefix = "self",
      },
      cargo = {
        loadOutDirsFromCheck = true
      },
      procMacro = {
        enable = true
      }, 
    }
  },
  single_file_support = true
}

-- PHP
lspconfig.intelephense.setup {
  on_attach = M.on_attach,
  capabilities = capabilities,

  cmd = { "intelephense", "--stdio" },
  filetypes = { "php" },
  single_file_support = true
}

-- Java
lspconfig.jdtls.setup {
  cmd = {
    "jdtls",
    "-configuration",
    "/home/runner/.cache/jdtls/config",
    "-data",
    "/home/runner/.cache/jdtls/workspace"
  },
  filetypes = { "java" },
  init_options = {
    jvm_args = {},
    workspace = "/home/runner/.cache/jdtls/workspace"
  },
  single_file_support = true
}
------------------------------------------------------------------
------------------------------------------------------------------

-- requires a file containing user's lspconfigs
local addlsp_confs = utils.load_config().plugins.options.lspconfig.setup_lspconf

if #addlsp_confs ~= 0 then
  require(addlsp_confs).setup_lsp(M.on_attach, capabilities)
end

return M
