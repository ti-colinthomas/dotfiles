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
      vim.diagnostic.config({
        virtual_text = {
          prefix = "●",  -- Customize the prefix symbol
          spacing = 2,    -- Space between the prefix and the message
        },
        signs = true,        -- Show signs in the sign column
        underline = true,    -- Underline problematic text
        update_in_insert = false, -- Don't update diagnostics while typing
        severity_sort = true, -- Sort diagnostics by severity
      })

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
