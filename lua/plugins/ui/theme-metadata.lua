local M = {}

M.theme = "light"

local initialized = false

function M.init_theme()
  local os_theme = os.getenv('OS_THEME')
  -- overrided by env variable
  if os_theme ~= "" then
    return os_theme
  end
  initialized = true
  return M.theme
end

function M.is_dark_theme()
  if not initialized then
    M.init_theme()
  end
  return M.theme == "dark" or M.theme == "Dark" or M.theme == "DARK"
end

function M.is_light_theme()
  return not M.is_dark_theme()
end

return M
