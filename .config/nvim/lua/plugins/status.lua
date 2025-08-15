return {
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function ()
      -- import tmux_utils
      local tmux_utils = require("custom.tmux_utils")

      -- Set the b section for lualine
      local section_b = {}
      if tmux_utils.is_tmux_active() then
        section_b = {tmux_utils.tmux_session_name, "branch", "diff", "diagnostics"}
      else
        section_b = {"branch", "diff", "diagnostics"}
      end

      local lualine = require("lualine")
      lualine.setup({
        options = {
          theme = "auto",
          section_separators = { left = "", right = "" },
          component_separators = { left = "", right = "" }
        },
        sections = {
          lualine_a = {"mode"},
          lualine_b = section_b,
          lualine_c = {},
          lualine_x = {"filetype"},
          lualine_y = {},
          lualine_z = {"location"}
        }
      })
    end
  }
}
