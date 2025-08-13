return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      {
        "folke/lazydev.nvim",
        ft = "lua", -- only load on lua files
        opts = {
          library = {
            -- See the configuration section for more details
            -- Load luvit types when the `vim.uv` word is found
            { path = "${3rd}/luv/library", words = { "vim%.uv" } },
          },
        },
      },
      {
        "mason-org/mason.nvim",
        opts = {}
      },
    },
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local lspconfig = require("lspconfig")

      -- Configure diagnostics
      -- See :help vim.diagnostic.Opts
      vim.diagnostic.config {
        severity_sort = true, -- Sort diagnostics by severity
        float = { border = 'rounded', source = 'if_many' },
        underline = { severity = vim.diagnostic.severity.ERROR }, -- Only underline errors
        -- Configure signs for diagnostics, using nerd fonts if available
        -- TODO: Add icons when nerd fonts not available
        signs = vim.g.have_nerd_font and {
          text = {
            [vim.diagnostic.severity.ERROR] = '󰅚 ',
            [vim.diagnostic.severity.WARN] = '󰀪 ',
            [vim.diagnostic.severity.INFO] = '󰋽 ',
            [vim.diagnostic.severity.HINT] = '󰌶 ',
          },
        } or {}, -- Use empty table if nerd fonts not available
        virtual_text = {
          prefix = "●",  -- Customize the prefix symbol
          source = 'if_many', -- Show the source of the diagnostic if there are multiple sources
          spacing = 2,
          format = function(diagnostic) -- Function to format the virtual text
            local diagnostic_message = {
              [vim.diagnostic.severity.ERROR] = diagnostic.message,
              [vim.diagnostic.severity.WARN] = diagnostic.message,
              [vim.diagnostic.severity.INFO] = diagnostic.message,
              [vim.diagnostic.severity.HINT] = diagnostic.message,
            }
            return diagnostic_message[diagnostic.severity]
          end,
        },
        update_in_insert = false, -- Don't update diagnostics while typing
      }

      -- Keymaps
      local on_attach = function(_, bufnr)
        local opts = { buffer = bufnr, silent = true }
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "grn", vim.lsp.buf.rename, opts)
        vim.keymap.set("n", "gca", vim.lsp.buf.code_action, opts)
      end
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      -- TODO: Need to check what this does
      -- capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

      lspconfig.lua_ls.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
          Lua = {
            diagnostics = { globals = { "vim" } },
          },
        },
      })
      lspconfig.ts_ls.setup({
        on_attach = on_attach,
        capabilities = capabilities
      })
    end,
  }
}
