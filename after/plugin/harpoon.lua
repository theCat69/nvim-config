local harpoon = require('harpoon')

harpoon:setup({
  settings = {
    save_on_change = false,
    excluded_filetypes = { "." }
  }
})

vim.keymap.set('n', '<C-m>', function() harpoon:list():append() end);
vim.keymap.set('n', '<C-e>', function() harpoon.ui:toggle_quick_menu(harpoon:list()) end);
vim.keymap.set('n', '<C-n>', function() harpoon:list():next() end);
vim.keymap.set('n', '<C-p>', function() harpoon:list():prev() end);
