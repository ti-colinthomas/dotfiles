-- This plugin might seem to go against the principle to avoid unnecessary plugins at all costs, but it is necessary to get the messages from neovim as this is hidden while combining the status bars from neovim and tmux.
-- The need for this plugin is mainly to integrate the neovim and tmux status bars, currently testing this out, but if it seems to be blocking more than being helpful, I might just remove it entirely
return {
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
    },
    dependencies = {
      {
        "MunifTanjim/nui.nvim",
      },
      {
        "rcarriga/nvim-notify",
        config = function ()
          require("notify").setup({
            merge_duplicates = false,
            background_colour = "#000000",
            fps = 30,
            icons = {
              DEBUG = "",
              ERROR = "",
              INFO = "",
              TRACE = "✎",
              WARN = ""
            },
            level = 2,
            minimum_width = 50,
            render = "minimal",
            stages = "fade_in_slide_out",
            time_formats = {
              notification = "%T",
              notification_history = "%FT%T"
            },
            timeout = 5000,
            top_down = true
          })
        end
      }
    },
    config = function ()
      local noice = require("noice")

      noice.setup({
        lsp = {
          -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
          override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = false,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
          },
        },
        presets= {
          bottom_search = true,
          command_palette = false, -- Repository README has this suggested as true, but this is interfering with popup items like code actions
          long_message_to_split = true,
          lsp_doc_border = true, -- Repository README has this set to false in suggested setup, but I don't like it at all
        },
        cmdline = {
          enabled = true,
          view = "cmdline",
          format = {
            cmdline = { pattern = "^:", icon = "", lang = "vim" },
          }
        },
      })
    end,
  }
}
