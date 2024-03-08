---@meta

local M = {}

local theme = "light"

local initialized = false

---@class Colors
---@field red string
---@field orange string
---@field green string
---@field blue string
---@field purple string
---@field background string
---@field background_secondary string

---@type Colors
local colors_light = {
  red = "#9D0006",
  orange = "#AF3A03",
  green = "#79740E",
  blue = "#076678",
  purple = "#8F3F71",
  background = "#000000",
  background_secondary = "#D3D3D3"
}

---@type Colors
local colors_dark = {
  red = "#FB4934",
  orange = "#FE8019",
  green = "#B8BB26",
  blue = "#83A598",
  purple = "#D3869B",
  -- should check background for dark theme and probably change it
  background = "#000000",
  background_secondary = "#D3D3D3"
}

local colors = colors_light

local function init_theme()
  local os_theme = os.getenv('OS_THEME')
  -- overrided by env variable
  if os_theme ~= "" then
    theme = os_theme
  end
  initialized = true
  if M.is_dark_theme() then
    colors = colors_dark
  end
  return theme
end

local function lazy_init()
  if not initialized then
    init_theme()
  end
end

---@return boolean
function M.is_dark_theme()
  lazy_init()
  return theme == "dark" or theme == "Dark" or theme == "DARK"
end

---@return boolean
function M.is_light_theme()
  return not M.is_dark_theme()
end

---@return Colors
function M.get_colors()
  lazy_init()
  return colors
end

return M
