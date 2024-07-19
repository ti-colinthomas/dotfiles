return {
	{
		'nvim-treesitter/nvim-treesitter',
		build = ':TSUpdate',
		opts = {
      ensure_installed = {
				'bash',
				'diff',
				'html',
				'lua',
				'luadoc',
				'markdown',
				'markdown_inline',
				'query',
				'vim',
				'vimdoc',
				-- 'css',
				-- 'csv',
				'dockerfile',
				-- 'gitignore',
				-- 'html',
				-- 'http', -- TODO: Find what this does, got it from craftzdog
				-- 'javascript',
				-- 'json',
				-- 'nginx',
				-- -- 'typescript', TODO: Check difference from javascript
				-- 'yaml'
			},
      -- Autoinstall languages that are not installed
      auto_install = true,
      highlight = {
        enable = true,
        -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
        --  If you are experiencing weird indenting issues, add the language to
        --  the list of additional_vim_regex_highlighting and disabled languages for indent.
        additional_vim_regex_highlighting = false
      },
      indent = { enable = true }
		}
	}
}