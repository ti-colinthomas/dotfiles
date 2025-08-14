return {
  "lewis6991/gitsigns.nvim",
  config = function()
    require("gitsigns").setup({
      signs = {
        add          = { text = "┃" },
        change       = { text = "┃" },
        delete       = { text = "_" },
        topdelete    = { text = "‾" },
        changedelete = { text = "~" },
        untracked    = { text = "┆" },
      },
      signs_staged = {
        add          = { text = "┃" },
        change       = { text = "┃" },
        delete       = { text = "_" },
        topdelete    = { text = "‾" },
        changedelete = { text = "~" },
        untracked    = { text = "┆" },
      },
      signs_staged_enable = true
    })

    -- Customize highlight colors
    local flavor = require("catppuccin").flavour or "mocha"
    local cp = require("catppuccin.palettes").get_palette(flavor)

    vim.api.nvim_set_hl(0, "GitSignsAdd",    { fg = cp.green })
    vim.api.nvim_set_hl(0, "GitSignsChange", { fg = cp.yellow })
    vim.api.nvim_set_hl(0, "GitSignsDelete", { fg = cp.red })
  end,
  event = "VeryLazy"
}
