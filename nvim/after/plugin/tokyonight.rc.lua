local status, tokyonight = pcall(require, "tokyonight")
if (not status) then return end

tokyonight.setup({
  style = "night", -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
  transparent = false, -- Enable this to disable setting the background color
  terminal_colors = true, -- Configure the colors used when opening a `:terminal` in Neovim
  styles = {
    -- Style to be applied to different syntax groups
    -- Value is any valid attr-list value for `:help nvim_set_hl`
    comments = { italic = true },
    keywords = { italic = true },
    functions = {},
    variables = {},
    -- Background styles. Can be "dark", "transparent" or "normal"
    sidebars = "dark", -- style for sidebars, see below
    floats = "dark", -- style for floating windows
  },
  sidebars = { "qf", "help" }, -- Set a darker background on sidebar-like windows. For example: `["qf", "vista_kind", "terminal", "packer"]`
  dim_inactive = true, -- dims inactive windows
  lualine_bold = false, -- When `true`, section headers in the lualine theme will be bold

  -- TODO: Borderless telescope is not working
  on_highlights = function(highlights, colors) -- Make Telescope borderless
    local prompt = "#2d3149"
    highlights.TelescopeNormal = {
      bg = colors.bg_dark,
      fg = colors.fg_dark,
    }
    highlights.TelescopeBorder = {
      bg = colors.bg_dark,
      fg = colors.bg_dark,
    }
    highlights.TelescopePromptNormal = {
      bg = prompt,
    }
    highlights.TelescopePromptBorder = {
      bg = prompt,
      fg = prompt,
    }
    highlights.TelescopePromptTitle = {
      bg = prompt,
      fg = prompt,
    }
    highlights.TelescopePreviewTitle = {
      bg = colors.bg_dark,
      fg = colors.bg_dark,
    }
    highlights.TelescopeResultsTitle = {
      bg = colors.bg_dark,
      fg = colors.bg_dark,
    }
  end,
})
