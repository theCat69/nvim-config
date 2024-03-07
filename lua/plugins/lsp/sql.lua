local cmd = {
  'DBUI',
  'DBUIToggle',
  'DBUIAddConnection',
  'DBUIFindBuffer',
}

local ft = {
  'sql', 'mysql', 'plsql'
}

local function init()
  -- Your DBUI configuration
  vim.g.db_ui_use_nerd_fonts = 1
  vim.keymap.set("n", "<leader>sql", "<Cmd>DBUIToggle<CR>")
end

---@type LazyPluginSpec[]
return {
  {
    'kristijanhusak/vim-dadbod-ui',
    dependencies = {
      { 'tpope/vim-dadbod',                     lazy = true },
      { 'kristijanhusak/vim-dadbod-completion', ft = ft,   lazy = true },
    },
    cmd = cmd,
    init = init,
  }
}
