-- Treesitter configuration with Neovim 0.11+ compatibility
return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    opts = {
      ensure_installed = {
        "bash",
        "python",
        "lua",
        "vim",
        "vimdoc",
        "markdown",
        "markdown_inline",
        "json",
        "yaml",
        "toml",
        "html",
        "css",
        "javascript",
        "typescript",
      },
      highlight = {
        enable = true,
      },
      indent = {
        enable = true,
      },
    },
  },
}
