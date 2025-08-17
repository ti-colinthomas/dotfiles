-- Variable to store the initial tmux window name
local initial_tmux_window_name = ""
local tmux_utils = require("custom.tmux_utils")

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.hl.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

-- Enable the sign column when in a git repository
vim.api.nvim_create_autocmd("BufEnter", {
  callback = function()
    local git_dir = vim.fn.finddir(".git", ".;")
    if git_dir ~= "" then
      vim.opt.signcolumn = "yes"
    else
      vim.opt.signcolumn = "auto"
    end
  end,
  desc = "Enable the sign column when in a git repository"
})

-- Rename the tmux window when a file is opened in neovim
vim.api.nvim_create_autocmd("BufEnter", {
  callback = function()
    -- Rename the tmux window based on file opened in neovim
    if tmux_utils.is_tmux_active() then
      if initial_tmux_window_name == "" then
        initial_tmux_window_name = tmux_utils.tmux_window_name()
      end
      local filename = vim.fn.expand("%:t")  -- Get the current file name
      if filename ~= "" then
        os.execute("tmux rename-window " .. filename)
      end
    end
  end,
  desc = "Change tmux window name based on the opened file"
})

-- If tmux was renamed to filename, change it back to previous name
vim.api.nvim_create_autocmd("VimLeave", {
  callback = function()
    -- Change tmux window name back to initial name
    if tmux_utils.is_tmux_active() then
      os.execute("tmux rename-window " .. initial_tmux_window_name)
    end
  end,
})

-- Action on file save
-- Trigger notification
vim.api.nvim_create_autocmd("BufWritePost", {
  callback = function(args)
    local file = vim.fn.fnamemodify(args.file, ":t")
    vim.notify("Saved " .. file, vim.log.levels.INFO)
  end,
})
