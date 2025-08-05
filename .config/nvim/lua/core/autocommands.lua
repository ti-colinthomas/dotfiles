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
})
