-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Keymap for yanking the complete buffer
vim.keymap.set('n', 'ya', '<cmd>:%y<CR>', { desc = 'Yank full buffer' })
