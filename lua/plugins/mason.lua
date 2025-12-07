-- Mason tool installer configuration
return {
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        -- Python tools (modern stack)
        "pyright",         -- Python LSP server
        "ruff",            -- Fast Python linter & formatter (replaces flake8, black, isort)
        "debugpy",         -- Python debugger

        -- Lua tools
        "stylua",         -- Lua formatter

        -- Shell tools
        "shellcheck",         -- Shell script linter
        "shfmt",              -- Shell script formatter

        -- Web development tools
        "typescript-language-server",          -- JavaScript/TypeScript LSP
        "svelte-language-server",              -- Svelte LSP
        "html-lsp",                            -- HTML LSP
        "css-lsp",                             -- CSS LSP
        "tailwindcss-language-server",         -- Tailwind CSS IntelliSense
        "biome",                               -- Modern Rust-powered linter & formatter (replaces ESLint + Prettier)
      },
    },
  },
}
