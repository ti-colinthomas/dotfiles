-- Function to check if neovim is running in tmux
local function is_running_in_tmux()
  return os.getenv("TMUX") ~= nil
end

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.hl.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
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
    if is_running_in_tmux() then
      local filename = vim.fn.expand('%:t')  -- Get the current file name
      if filename ~= '' then
        os.execute("tmux rename-window " .. filename)
      end
    end
  end,
  desc = "Change tmux window name based on the opened file"
})



-- -- Callback on exiting vim
-- vim.api.nvim_create_autocmd("VimLeave", {
--   callback = function()
--     -- Reset cursor to blinking line (adjust for your terminal)
--     vim.fn.system("printf '\\e[5 q'")
--   end,
-- })
