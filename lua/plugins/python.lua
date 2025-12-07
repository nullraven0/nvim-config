-- Python development configuration with Ruff
return {
  -- Configure LSP servers for Python
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        -- Pyright for type checking and intellisense
        pyright = {
          settings = {
            python = {
              analysis = {
                typeCheckingMode = "basic",
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
                diagnosticMode = "workspace",
              },
            },
          },
        },
        -- Ruff LSP for fast linting
        ruff = {
          init_options = {
            settings = {
              -- Ruff server settings
              organizeImports = true,
              fixAll = true,
            },
          },
        },
      },
    },
  },

  -- Configure formatting with Ruff
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        python = { "ruff_format", "ruff_organize_imports" },
      },
      formatters = {
        ruff_organize_imports = {
          command = "ruff",
          args = { "check", "--select", "I", "--fix", "--stdin-filename", "$FILENAME", "-" },
          stdin = true,
        },
      },
    },
  },

  -- Configure linting with Ruff
  {
    "mfussenegger/nvim-lint",
    optional = true,
    opts = {
      linters_by_ft = {
        python = { "ruff" },
      },
    },
  },
}
