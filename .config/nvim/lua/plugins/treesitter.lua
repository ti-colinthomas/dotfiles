return {
  "nvim-treesitter/nvim-treesitter",
  branch = "master",
  lazy = false,
  build = ":TSUpdate",

  config = function()
    require("nvim-treesitter.configs").setup({
      highlight = {
        enable = true
      },

      indent = {
        enable = true
      },

      ensure_installed = {
        "json",
        "javascript",
        "typescript",
        "yaml",
        "css",
        "html",
        "markdown",
        "lua",
        "bash",
        "dockerfile",
        "vim",
        "gitignore"
      },

      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "tt",
          node_incremental = "tt",
          scope_incremental = false,
          node_decremental = "<bs>",
        }
      }
    })
  end
}
