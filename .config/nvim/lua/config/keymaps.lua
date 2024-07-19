-- Remove search highlight on Esc
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Exit from terminal using Esc-Esc
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Buffers
vim.keymap.set('n', 'b,', ':bnext<CR>', { desc = 'Exit terminal mode' })
vim.keymap.set('n', 'b.', ':bnext<CR>', { desc = 'Exit terminal mode' })

-- Tabs cycle
vim.keymap.set("n", "<tab>", ":tabnext<CR>", opts)
vim.keymap.set("n", "<s-tab>", ":tabprev<Return>", opts)

-- Default mapping that has not been changed due to some issues
-- Open file under cursor in a new tab
-- <C-w>gf
