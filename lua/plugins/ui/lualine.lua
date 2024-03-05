-- Set lualine as statusline
-- See `:help lualine.txt`
local function config()
  require('lualine').setup {
    options = {
      icons_enabled = false,
      theme = 'onedark',
      component_separators = '|',
      section_separators = '',
    },
  }
end


---@type LazyPluginSpec[]
return {
  {
    'nvim-lualine/lualine.nvim',
    config = config,
    lazy = false
  }
}
