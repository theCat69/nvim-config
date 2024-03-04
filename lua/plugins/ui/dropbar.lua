local M = {}

M.lazy = true

M.plugin = {
  -- drop bar insane shit
  'Bekaboo/dropbar.nvim',
  -- optional, but required for fuzzy finder support
  dependencies = {
    'nvim-telescope/telescope-fzf-native.nvim'
  }
}


function M.setup()
  vim.keymap.set('n', '<leader>db', require('dropbar.api').pick)
end

return M
