-- Set colorscheme
vim.o.termguicolors = true

-- dark theme
-- vim.cmd [[colorscheme one]]

-- light theme
-- vim.g.one_allow_italics = 1
vim.g.gruvbox_contrast_light = "hard"
vim.g.gruvbox_improved_warnings = 1
vim.g.gruvbox_sign_column = "bg0"
-- vim.g.gruvbox_transparent_bg = 1
vim.cmd [[set background=light]]
vim.cmd [[colorscheme gruvbox]]

-- vim.g.gruvbox_transparent_bg = 0

-- netrw preferences
vim.g.netrw_browse_split = 0
-- vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25

-- start specific to nvim-tree plugin
-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
-- end specific to nvim-tree plugin

-- transparent background
vim.cmd('highlight Normal guibg=none')
vim.cmd('highlight NonText guibg=none')
