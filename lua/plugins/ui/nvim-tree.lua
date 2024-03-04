-- just to get a nice file tree like in any code editors
-- it can slow down startup a lot on low spec device

local M = {}

M.lazy = true

M.plugin = {
  'nvim-tree/nvim-tree.lua',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  }
}

local function on_attach(bufnr)
  local api = require "nvim-tree.api"

  -- default mappings
  api.config.mappings.default_on_attach(bufnr)

  -- custom mappings
  vim.keymap.set('n', '<leader>tt', '<Cmd>NvimTreeToggle<CR>', { silent = true })
  vim.keymap.set('n', '<leader>tf', '<Cmd>NvimTreeFindFile<CR>', { silent = true })
end

M.setup = function()
  require("nvim-tree").setup({
    actions = {
      open_file = {
        quit_on_open = true,
      },
    },
    diagnostics = {
      enable = true,
      show_on_dirs = true,
    },
    on_attach = on_attach,
  })
end

return M
