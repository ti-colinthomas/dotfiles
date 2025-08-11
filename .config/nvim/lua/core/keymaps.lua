-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Keymap for yanking, changing and deleting the complete buffer
vim.keymap.set('n', 'ya', '<cmd>:%y<CR>', { desc = '[Y]ank [a]ll' })
vim.keymap.set('n', 'ca', '<cmd>:%c<CR><Esc>i', { desc = '[C]hange [a]ll' })
vim.keymap.set('n', 'da', '<cmd>:%d<CR>', { desc = '[D]elete [a]ll' })
