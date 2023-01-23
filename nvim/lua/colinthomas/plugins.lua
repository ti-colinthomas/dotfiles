local status, packer = pcall(require, "packer")
if (not status) then
  print("Packer is not installed")
  return
end

vim.cmd [[packadd packer.nvim]]

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
  autocmd!
  autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Have packer use a popup window
packer.init({
  display = {
    open_fn = function()
      return require("packer.util").float({ border = "rounded" })
    end,
  },
})

packer.startup(function(use)
  use 'wbthomason/packer.nvim'

  use 'folke/tokyonight.nvim' -- Theme
  use 'nvim-lualine/lualine.nvim' -- Status line

  use {
    'nvim-treesitter/nvim-treesitter', -- Syntax highlighting and more
    run = ':TSUpdate'
  }

  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.0', -- File explorer
    requires = {
      { 'nvim-lua/plenary.nvim' },
      { 'nvim-telescope/telescope-file-browser.nvim' },
      { 'nvim-tree/nvim-web-devicons' } -- Icons
    }
  }

  use 'akinsho/nvim-bufferline.lua' -- For tabs
  use 'numToStr/Comment.nvim' -- Commenting

  use 'windwp/nvim-autopairs' -- Auto open/close pairs
  use 'windwp/nvim-ts-autotag'

  use {
    'neovim/nvim-lspconfig', -- LSP
    requires = {
      { 'hrsh7th/nvim-cmp' }, -- Completion
      { 'hrsh7th/cmp-nvim-lsp' }, -- Completion
      { 'hrsh7th/cmp-buffer' }, -- Completion from file
      { 'hrsh7th/cmp-path' }, -- Completion for path
      { 'L3MON4D3/LuaSnip' }, -- Snippets
      { 'saadparwaiz1/cmp_luasnip' }, -- Use luasnip as a completion source
      { 'rafamadriz/friendly-snippets' } -- Snippets
    }
  }

  use {
    'lewis6991/gitsigns.nvim',
    tag = 'release'
  }

  use {
    'jose-elias-alvarez/null-ls.nvim',
    requires = {
      { 'nvim-lua/plenary.nvim' }
    }
  }
end)
