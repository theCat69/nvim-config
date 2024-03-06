local function config()
  vim.keymap.set('n', '<leader>db', require('dropbar.api').pick)
end

---@type LazyPluginSpec[]
return {
  {
    -- drop bar insane shit
    'Bekaboo/dropbar.nvim',
    -- optional, but required for fuzzy finder support
    dependencies = {
      'nvim-telescope/telescope-fzf-native.nvim'
    },
    config = config,
  }
}
