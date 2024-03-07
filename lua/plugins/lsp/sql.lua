-- cmd that lazy load the ui plugin and dadbod
local cmd = {
  'DBUI',
  'DBUIToggle',
  'DBUIAddConnection',
  'DBUIFindBuffer',
}

-- filetypes that enable dadbod completion
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
      'tpope/vim-dadbod',
      { 'kristijanhusak/vim-dadbod-completion', ft = ft },
    },
    cmd = cmd,
    init = init,
  }
}
