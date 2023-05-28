local harpoon = require('harpoon')
local harpoon_mark = require('harpoon.mark')
local harpoon_ui = require('harpoon.ui')

harpoon.setup({
  tabline = true,
  excluded_filetypes = { "." }
})

vim.keymap.set('n', '<C-m>', harpoon_mark.add_file);
vim.keymap.set('n', '<C-e>', harpoon_ui.toggle_quick_menu);
vim.keymap.set('n', '<C-n>', harpoon_ui.nav_next);
vim.keymap.set('n', '<C-p>', harpoon_ui.nav_prev);
