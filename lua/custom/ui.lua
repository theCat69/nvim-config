-- Set colorscheme
vim.o.termguicolors = true
vim.cmd [[colorscheme onedark]]

vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25

vim.cmd('highlight Normal guibg=none')
vim.cmd('highlight NonText guibg=none')
