-- Web development configuration: LSP servers and formatting
return {
  -- Configure LSP servers
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        -- TypeScript/JavaScript
        tsserver = {
          settings = {
            javascript = {
              inlayHints = {
                includeInlayParameterNameHints = "all",
                includeInlayFunctionParameterTypeHints = true,
                includeInlayVariableTypeHints = true,
              },
            },
            typescript = {
              inlayHints = {
                includeInlayParameterNameHints = "all",
                includeInlayFunctionParameterTypeHints = true,
                includeInlayVariableTypeHints = true,
              },
            },
          },
        },
        -- HTML
        html = {
          filetypes = { "html", "htmldjango" },
        },
        -- CSS
        cssls = {
          settings = {
            css = {
              validate = true,
              lint = {
                unknownAtRules = "ignore",                 -- Don't warn on Tailwind @apply, @layer, etc.
              },
            },
            scss = {
              validate = true,
              lint = {
                unknownAtRules = "ignore",
              },
            },
            less = {
              validate = true,
              lint = {
                unknownAtRules = "ignore",
              },
            },
          },
        },
        -- Svelte
        svelte = {
          settings = {
            svelte = {
              plugin = {
                svelte = {
                  compilerWarnings = {
                    ["a11y-missing-attribute"] = "ignore",
                  },
                },
              },
            },
          },
        },
        -- Tailwind CSS
        tailwindcss = {
          filetypes = {
            "html",
            "css",
            "scss",
            "javascript",
            "javascriptreact",
            "typescript",
            "typescriptreact",
            "vue",
            "svelte",
          },
          settings = {
            tailwindCSS = {
              experimental = {
                classRegex = {
                  -- Alpine.js x-bind:class
                  [[x-bind:class="([^"]*)]],
                  [[:class="([^"]*)]],
                  -- Regular class attributes
                  [[class="([^"]*)]],
                  [[class: "([^"]*)]],
                  [[class: '([^']*)]],
                  [[className="([^"]*)]],
                  [[className: "([^"]*)]],
                },
              },
            },
          },
        },
        -- ESLint
        eslint = {
          settings = {
            workingDirectory = { mode = "auto" },
          },
        },
      },
    },
  },

  -- Configure formatting with conform.nvim (LazyVim's formatter)
  -- Using Biome - modern Rust-powered formatter & linter (like Ruff for Python)
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        javascript = { "biome" },
        javascriptreact = { "biome" },
        typescript = { "biome" },
        typescriptreact = { "biome" },
        json = { "biome" },
        jsonc = { "biome" },
        svelte = { "biome" },
      },
    },
  },

  -- Configure linting with nvim-lint (LazyVim's linter)
  -- Using Biome - modern Rust-powered formatter & linter (like Ruff for Python)
  {
    "mfussenegger/nvim-lint",
    optional = true,
    opts = {
      linters_by_ft = {
        javascript = { "biome" },
        javascriptreact = { "biome" },
        typescript = { "biome" },
        typescriptreact = { "biome" },
        json = { "biome" },
      },
    },
  },
}
