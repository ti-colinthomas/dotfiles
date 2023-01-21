-- Functional wrapper for mapping custom keybindings
function map(mode, lhs, rhs, opts)
  local options = { noremap = true }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- Don't yank with x
map('n', 'x', '"_x')

-- New tab from current directory
map('n', '<C-t>', ':tabedit . <CR>')

-- Close the current tab
map('n', '<C-w>', ':tabclose <CR>')

-- Add semicolon to end of line
map('n', ' ;', 'A;<Esc>')
