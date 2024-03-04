-- Set lualine as statusline
-- See `:help lualine.txt`

local M = {}

M.lazy = false

M.plugin = {
  'nvim-lualine/lualine.nvim'
}

M.setup = function()
  require('lualine').setup {
    options = {
      icons_enabled = false,
      theme = 'onedark',
      component_separators = '|',
      section_separators = '',
    },
  }
end

return M
