return {
  "vimpostor/vim-tpipeline",
  dependencies = {
    "nvim-lualine/lualine.nvim",
    "nvim-tree/nvim-web-devicons"
  },
  config = function ()
    local lualine = require("lualine")

    lualine.setup({
      options = {
        theme = "catppuccin",
      },
      sections = {
        lualine_a = {"mode"},
        lualine_b = {"branch", "diff", "diagnostics"},
        lualine_c = {},
        lualine_x = {"filetype"},
        -- lualine_x = {"encoding", "fileformat", "filetype"},
        lualine_y = {},
        lualine_z = {"location"}
      },
    })

    vim.g.tpipeline_autoembed = 1
    vim.g.tpipeline_restore = 1
    vim.g.tpipeline_clearstl = 1
  end
}
