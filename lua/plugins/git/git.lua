local cmd = "Git"

local function gitsign_config()
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

---@type LazyPluginSpec[]
return {
  {
    'lewis6991/gitsigns.nvim',
    config = gitsign_config,
  },
  {
    'tpope/vim-rhubarb',
    dependencies = {
      'tpope/vim-fugitive',
    },
    cmd = cmd
  },
}
