-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Keymap for yanking, changing and deleting the complete buffer
vim.keymap.set("n", "yaa", "<cmd>:%y<CR>", { desc = "Yank all" })
vim.keymap.set("n", "caa", "<cmd>:%c<CR><Esc>i", { desc = "Change all" })
vim.keymap.set("n", "daa", "<cmd>:%d<CR>", { desc = "Delete all" })

-- Indent the complete buffer
-- TODO: Code formatting needs to be integrated with the LSP
-- FIXME: Moves the position of the cursor while indenting
vim.keymap.set("n", "==", "mzgg=G`z", { desc = "Indent buffer" })

-- Cycle open buffers
vim.keymap.set("n", "<Tab>", "<cmd>:bnext<CR>", { desc = "Show next open buffer" })
vim.keymap.set("n", "<S-Tab>", "<cmd>:bprev<CR>", { desc = "Show next open buffer" })

-- Increment / decrement
vim.keymap.set("n", "+", "<C-a>", { desc = "Increment" })
vim.keymap.set("n", "-", "<C-x>", { desc = "Decrement" })

-- TODO: Terminal
vim.keymap.set("n", "sh", function ()
  print("Launch a terminal")
end, { desc = "Launch a terminal" })

-- Esc does not work well on termius on iPad
-- Adding this to allow for usage on iPad
vim.keymap.set("i", "jj", "<Esc>", { noremap = false })
-- Additionally check the following plugins for keymapping
-- plugins/lsp.lua
-- plugins/treesitter.lua
-- plugins/telescope.lua
