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

vim.cmd('highlight! HarpoonInactive guibg=NONE guifg=#63698c')
vim.cmd('highlight! HarpoonActive guibg=NONE guifg=white')
vim.cmd('highlight! HarpoonNumberActive guibg=NONE guifg=#7aa2f7')
vim.cmd('highlight! HarpoonNumberInactive guibg=NONE guifg=#7aa2f7')
vim.cmd('highlight! TabLineFill guibg=NONE guifg=white')
