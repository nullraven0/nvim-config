-- Alpine.js support configuration
return {
  -- Add Alpine.js treesitter parser
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed or {}, {
        "html",
        "javascript",
      })
    end,
  },

  -- Configure nvim-cmp for Alpine.js attribute completion
  {
    "hrsh7th/nvim-cmp",
    optional = true,
    dependencies = {
      {
        "roobert/tailwindcss-colorizer-cmp.nvim",
        config = true,
      },
    },
    opts = function(_, opts)
      -- Format tailwind colors in completion menu
      local format_kinds = opts.formatting.format
      opts.formatting.format = function(entry, item)
        format_kinds(entry, item)
        return require("tailwindcss-colorizer-cmp").formatter(entry, item)
      end
    end,
  },

  -- Better HTML/Alpine.js editing with auto-close tags
  {
    "windwp/nvim-ts-autotag",
    event = "InsertEnter",
    opts = {
      opts = {
        enable_close = true,
        enable_rename = true,
        enable_close_on_slash = true,
      },
    },
  },

  -- Alpine.js syntax highlighting in HTML
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        html = {
          filetypes = { "html", "htmldjango" },
          init_options = {
            configurationSection = { "html", "css", "javascript" },
            embeddedLanguages = {
              css = true,
              javascript = true,
            },
            provideFormatter = false,             -- Use Biome for formatting instead
          },
          settings = {
            html = {
              format = {
                enable = false,                 -- Disable built-in formatter in favor of Biome
              },
              -- Recognize Alpine.js directives
              customData = {
                {
                  version = 1.1,
                  tags = {},
                  globalAttributes = {
                    {
                      name = "x-data",
                      description = "Alpine.js reactive data",
                    },
                    {
                      name = "x-init",
                      description = "Alpine.js initialization",
                    },
                    {
                      name = "x-show",
                      description = "Alpine.js conditional display",
                    },
                    {
                      name = "x-if",
                      description = "Alpine.js conditional rendering",
                    },
                    {
                      name = "x-for",
                      description = "Alpine.js loop",
                    },
                    {
                      name = "x-bind",
                      description = "Alpine.js attribute binding",
                    },
                    {
                      name = "x-on",
                      description = "Alpine.js event listener",
                    },
                    {
                      name = "x-text",
                      description = "Alpine.js text content",
                    },
                    {
                      name = "x-html",
                      description = "Alpine.js HTML content",
                    },
                    {
                      name = "x-model",
                      description = "Alpine.js two-way binding",
                    },
                    {
                      name = "x-cloak",
                      description = "Alpine.js hide until ready",
                    },
                    {
                      name = "x-transition",
                      description = "Alpine.js transitions",
                    },
                    {
                      name = "x-ref",
                      description = "Alpine.js element reference",
                    },
                    {
                      name = "@click",
                      description = "Alpine.js click handler (shorthand)",
                    },
                    {
                      name = "@submit",
                      description = "Alpine.js submit handler (shorthand)",
                    },
                    {
                      name = ":class",
                      description = "Alpine.js class binding (shorthand)",
                    },
                  },
                },
              },
            },
          },
        },
      },
    },
  },
}
