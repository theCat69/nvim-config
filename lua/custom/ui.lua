local function light_theme()
  vim.g.gruvbox_contrast_light = "hard"
  vim.g.gruvbox_improved_warnings = 1
  vim.g.gruvbox_sign_column = "bg0"
  vim.cmd [[set background=light]]
end

local function dark_theme()
  -- vim.g.gruvbox_transparent_bg = 0
  vim.cmd [[set background=dark]]
end

-- Set colorscheme
vim.o.termguicolors = true

-- theme
local os_theme = os.getenv('OS_THEME')
if os_theme == 'dark' or os_theme == 'DARK' or os_theme == 'Dark' then
  dark_theme()
else
  light_theme()
end

vim.cmd [[colorscheme gruvbox]]

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
