--themes

local colors = require("metadata.ui").get_colors()

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
  if require("metadata.ui").is_dark_theme() then
    dark_theme()
  else
    light_theme()
  end

  vim.cmd [[colorscheme gruvbox]]

  -- transparent background
  vim.cmd('highlight Normal guibg=none')
  vim.cmd('highlight NonText guibg=none')

  -- This should be set after the theme or the cursor will be overwritted by the theme
  -- cursor change color when mode change and blinking insert cursor
  vim.api.nvim_set_hl(0, "iCursor", { fg = colors.blue, bg = colors.blue })
  vim.api.nvim_set_hl(0, "vCursor", { fg = colors.purple, bg = colors.purple })
  vim.api.nvim_set_hl(0, "Cursor", { fg = colors.green, bg = colors.green })
  vim.opt.guicursor =
  "n-c-sm:block-Cursor,v:block-vCursor,i-ci-ve:block-iCursor-blinkwait500-blinkoff200-blinkon500,r-cr-o:hor20"
end

---@type LazyPluginSpec
return {
  'morhetz/gruvbox',
  priority = 1000,
  config = config
}
