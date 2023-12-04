-- empty setup using defaults
require("nvim-tree").setup()
-- require("nvim-tree").setup {
--   actions = {
--     open_file = {
--       quit_on_open = true,
--     },
--   },
--   diagnostics = {
--     enable = true,
--     show_on_dirs = true,
--   },
-- }

vim.keymap.set('n', '<leader>tt', '<Cmd>NvimTreeToggle<CR>', { silent = true })
vim.keymap.set('n', '<leader>tf', '<Cmd>NvimTreeFindFile<CR>', { silent = true })
