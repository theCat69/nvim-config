local function my_on_attach(bufnr)
  local api = require "nvim-tree.api"

  local function opts(desc)
    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  -- default mappings
  api.config.mappings.default_on_attach(bufnr)

  -- custom mappings
  vim.keymap.set('n', '<leader>tt', '<Cmd>NvimTreeToggle<CR>', { silent = true })
  vim.keymap.set('n', '<leader>tf', '<Cmd>NvimTreeFindFile<CR>', { silent = true })
end

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
  on_attach = my_on_attach,
})
