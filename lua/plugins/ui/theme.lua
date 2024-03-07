--themes
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

local function config()
  local theme = require("plugins.ui.theme-metadata").init_theme()

  if theme == 'dark' or theme == 'DARK' or theme == 'Dark' then
    dark_theme()
    require("plugins.ui.theme-metadata").theme = theme
  else
    light_theme()
  end

  vim.cmd [[colorscheme gruvbox]]

  -- transparent background
  vim.cmd('highlight Normal guibg=none')
  vim.cmd('highlight NonText guibg=none')

  -- This should be set after the theme or the cursor will be overwritted by the theme
  -- cursor change color when mode change and blinking insert cursor
  vim.api.nvim_set_hl(0, "iCursor", { fg = '#00BFFF', bg = '#00BFFF' })
  vim.api.nvim_set_hl(0, "vCursor", { fg = '#EE82EE', bg = '#EE82EE' })
  vim.api.nvim_set_hl(0, "Cursor", { fg = '#90EE90', bg = '#90EE90' })
  vim.opt.guicursor =
  "n-c-sm:block-Cursor,v:block-vCursor,i-ci-ve:block-iCursor-blinkwait500-blinkoff200-blinkon500,r-cr-o:hor20"
end

---@type LazyPluginSpec[]
return {
  {
    'morhetz/gruvbox',
    priority = 1000,
    config = config
  }
}
