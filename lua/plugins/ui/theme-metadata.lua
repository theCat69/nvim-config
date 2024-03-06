local M = {}

M.theme = "light"

function M.init_theme()
  local os_theme = os.getenv('OS_THEME')
  -- overrided by env variable
  if os_theme ~= "" then
    return os_theme
  end
  return M.theme
end

return M
