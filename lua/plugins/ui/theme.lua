local M = {}

M.lazy = false

M.plugin = {
  'morhetz/gruvbox',
  priority = 1000
}

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

M.setup = function(theme)
  local os_theme = os.getenv('OS_THEME')
  -- overrided by env variable
  if os_theme ~= "" then
    theme = os_theme
  end

  if theme == 'dark' or theme == 'DARK' or theme == 'Dark' then
    dark_theme()
  else
    light_theme()
  end

  vim.cmd [[colorscheme gruvbox]]

  -- transparent background
  vim.cmd('highlight Normal guibg=none')
  vim.cmd('highlight NonText guibg=none')
end

return M
