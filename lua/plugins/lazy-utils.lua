---Helper to integrate my files into lazy setup for plugins
---@class LazyUtils
local M = {}

local plugins = {}

---Register one or more plugins
---@param plug LazyPluginSpec[] array of lazy plugins
function M.register_plugin(plug)
  for _, v in ipairs(plug) do
    table.insert(plugins, v)
  end
end

---@return LazyPluginSpec[]
function M.get_plugins()
  return plugins
end

return M
