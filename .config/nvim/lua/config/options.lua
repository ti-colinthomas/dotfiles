vim.opt.encoding = 'utf-8'
vim.opt.fileencoding = 'utf-8'

-- Line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- TODO: Check these
vim.opt.breakindent = true
vim.opt.smartindent = true
vim.opt.autoindent = true

-- Copy to system clipboard
vim.opt.clipboard = 'unnamedplus'

vim.opt.undofile = true

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.signcolumn = 'yes'

vim.opt.shiftwidth = 2
vim.opt.tabstop = 2

vim.opt.list = false
-- vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

vim.opt.cursorline = true

-- Show lines at the bottom
vim.opt.scrolloff = 10

vim.opt.termguicolors = true

-- Show substitutions live
vim.opt.inccommand = 'split'

-- TODO: Test this
-- Finding files - Search down into subfolders
vim.opt.path:append({ '**' })

-- TODO: Test this
-- Ignore node modules folder
vim.opt.wildignore:append({ "*/node_modules/*" })
-- Ignore certain lock files
vim.opt.wildignore:append({ "*-lock.json" })

vim.opt.hlsearch = true
