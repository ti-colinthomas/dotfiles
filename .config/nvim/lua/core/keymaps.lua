-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Keymap for yanking, changing and deleting the complete buffer
vim.keymap.set('n', 'yaa', '<cmd>:%y<CR>', { desc = 'Yank all' })
vim.keymap.set('n', 'caa', '<cmd>:%c<CR><Esc>i', { desc = 'Change all' })
vim.keymap.set('n', 'daa', '<cmd>:%d<CR>', { desc = 'Delete all' })

-- Indent the complete buffer
vim.keymap.set('n', '==', 'mzgg=G`z', { desc = 'Indent buffer' })

-- Additionally check the following plugins for keymapping
-- plugins/lsp.lua
-- plugins/treesitter.lua
