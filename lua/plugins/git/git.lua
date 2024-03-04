local M = {}

M.lazy = true

M.plugin = {
  'lewis6991/gitsigns.nvim',
  dependencies = {
    { 'tpope/vim-fugitive' },
    { 'tpope/vim-rhubarb' },
  }
}

function M.setup()
  require('gitsigns').setup {
    signs = {
      add = { text = '+' },
      change = { text = '~' },
      delete = { text = '_' },
      topdelete = { text = '‾' },
      changedelete = { text = '~' },
    },
  }
end

return M
