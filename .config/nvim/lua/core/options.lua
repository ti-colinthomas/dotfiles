-- Leader keys
vim.g.mapleader = " "                   -- Set the leader key
vim.g.maplocalleader = " "              -- Set the local leader key

vim.g.have_nerd_font = true             -- Nerd fonts installed

vim.opt.title = true                    -- Use current buffer name and path for window title

-- Line numbers
vim.opt.number = true                   -- Show line numbers
vim.opt.relativenumber = true           -- Show relative numbers

-- Sync clipboard between OS and Neovim.
-- Schedule the setting after `UiEnter` because it can increase startup-time.
-- See `:help "clipboard"`
vim.schedule(function()
  vim.o.clipboard = "unnamedplus"
end)

-- Tab size
vim.opt.tabstop = 2                     -- How many spaces are shown per Tab
vim.opt.softtabstop = 2                 -- How many spaces are applied when pressing Tab
vim.opt.shiftwidth = 2                  -- Amount to indent with << and >>
vim.opt.expandtab = true                -- Convert tabs to spaces

vim.opt.breakindent = true              -- Every wrapped line will continue visually indented

vim.opt.cursorline = true               -- Highlight the line the cursor is on

vim.opt.termguicolors = true

vim.opt.showmode = false                -- Don't show vim mode

vim.opt.undofile = true                 -- Save undo history between sessions

-- If performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
-- instead raise a dialog asking if you wish to save the current file(s)
-- See `:help "confirm"`
vim.opt.confirm = true

-- Search options
-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.inccommand = "split"            -- Show a pane at the bottom for previewing search and replace operations

vim.opt.winborder = "rounded"           -- default border for floating windowd

vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

vim.opt.scrolloff = 5                   -- Minimal number of screen lines to keep above and below the cursor.

vim.opt.mouse = ""                      -- Disabling mouse interaction
