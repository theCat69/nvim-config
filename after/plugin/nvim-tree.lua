-- empty setup using defaults
require("nvim-tree").setup()

vim.keymap.set('n', '<leader>tt', '<Cmd>NvimTreeToggle<CR>', { silent = true })
vim.keymap.set('n', '<leader>tf', '<Cmd>NvimTreeFindFile<CR>', { silent = true })
