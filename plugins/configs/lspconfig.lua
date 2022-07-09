local M = {}


M.setup_lsp = function(attach, capabilities)
  local lspconfig = require "lspconfig"

  -- lspservers with default config
  local servers = {
    "html",
    "clangd",
    "gopls",
    "jdtls",
    "intelephense",
    "rust-analyzer",
    "sqls",
    "tailwindcss",
    "tsserver",
    "pyright",
    "sumneko_lua"
  }

  for _, lsp in ipairs(servers) do

    if lsp == "tsserver" then
      lspconfig.tsserver.setup {
        on_attach = require "lsp-format".on_attach,
        capabilities = capabilities,

        cmd = {
          "typescript-language-server",
          "--stdio"
        },
        filetypes = {
          "javascript",
          "javascriptreact",
          "javascript.jsx",
          "typescript",
          "typescriptreact",
          "typescript.tsx"
        },
        init_options = {
          hostInfo = "neovim"
        },
        single_file_support = true
      }

    elseif lsp == "rust-analyzer" then
      lspconfig.rust_analyzer.setup {
        on_attach = require "lsp-format".on_attach,
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

    elseif lsp == "clangd" then
      lspconfig.clangd.setup {
        on_attach = require "lsp-format".on_attach,
        capabilities = capabilities,

        cmd = { "clangd" },
        filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
        init_options = {
          documentFormatting = true
        },
        single_file_support = true
      }

    elseif lsp == "html" then
      lspconfig.html.setup {
        on_attach = require "lsp-format".on_attach,
        capabilities = capabilities,

        cmd = { "vscode-html-language-server", "--stdio" },
        filetypes = { "html" },
        init_options = {
          documentFormatting = true, -- Format document
          configurationSection = { "html", "css", "javascript" },
          embeddedLanguages = {
            css = true,
            javascript = true,
          },
          provideFormatter = true
        },
        single_file_support = true,
      }

    elseif lsp == "gopls" then
      lspconfig.gopls.setup {
        on_attach = M.on_attach,
        capabilities = capabilities,

        cmd = { "gopls" },
        filetypes = { "go", "gomod", "gotmpl" },
        single_file_support = true
      }

    elseif lsp == "jdtls" then
      lspconfig.jdtls.setup {
        on_attach = require "lsp-format".on_attach,
        capabilities = capabilities,

        cmd = { "jdtls" },
        filetypes = { "java" },
        init_options = {
          documentFormatting = true
        },
        single_file_support = true
      }

    elseif lsp == "intelephense" then
      lspconfig.intelephense.setup {
        on_attach = require "lsp-format".on_attach,
        capabilities = capabilities,

        cmd = { "intelephense", "--stdio" },
        filetypes = { "php" },
        init_options = {
          documentationFormat = true
        },
        single_file_support = true
      }

    elseif lsp == "sqls" then
      lspconfig.sqls.setup {
        on_attach = require "lsp-format".on_attach,
        capabilities = capabilities,

        cmd = { "sqls" },
        init_options = {
          documentFormatting = true
        },
        filetypes = { "sql", "mysql" },
        single_file_support = true,
      }

    elseif lsp == "sumneko_lua" then
      lspconfig.sumneko_lua.setup {
        on_attach = require "lsp-format".on_attach,
        capabilities = capabilities,
        settings = {
          init_options = {
            documentFormatting = true
          },
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

    elseif lsp == "pyright" then
      lspconfig.pyright.setup {
        on_attach = require "lsp-format".on_attach,
        capabilities = capabilities,

        cmd = { "pyright-langserver", "--stdio" },
        init_options = {
          documentFormatting = true -- Keknya pyright gk suport formatter
        },
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

    elseif lsp == "tailwindcss" then
      lspconfig.tailwindcss.setup {
        on_attach = require "lsp-format".on_attach,
        capabilities = capabilities,
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

    end
  end
end
return M
