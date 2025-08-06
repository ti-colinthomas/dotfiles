-- Set the leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Nerd fonts
vim.g.have_nerd_font = true

-- Make line numbers default
vim.o.number = true
-- relative
vim.o.relativenumber = true

-- Sync clipboard between OS and Neovim.
-- Schedule the setting after `UiEnter` because it can increase startup-time.
-- See `:help 'clipboard'`
vim.schedule(function()
  vim.o.clipboard = 'unnamedplus'
end)

-- Tab size
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

-- Highlight the light the cursor is on
vim.opt.cursorline = true

vim.opt.termguicolors = true

-- Don't show mode
vim.opt.showmode = false

-- Save undo history
vim.opt.undofile = true

-- if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
-- instead raise a dialog asking if you wish to save the current file(s)
-- See `:help 'confirm'`
vim.opt.confirm = true

-- Search options
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Show a pane at the bottom for previewing search and replace operations
vim.opt.inccommand = 'split'

-- default border for floating windowd
vim.opt.winborder = 'rounded'
