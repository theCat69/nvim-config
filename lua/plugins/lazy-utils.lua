---Helper to integrate my files into lazy setup for plugins
---@class LazyUtils
local M = {}

local plugins = {}

function M.append_tables_array(tab, tab_to_append)
  for _, v in ipairs(tab_to_append) do
    table.insert(tab, v)
  end
end

---Register one or more plugins
---@param plug LazyPluginSpec|LazyPluginSpec[]
function M.register_plugin(plug)
  local pluginSpec = unpack(plug)
  -- this means the file return a LazyPluginSpec
  if type(pluginSpec) ~= "table" then
    table.insert(plugins, plug)
  else -- assuming a LazyPluginSpec[] otherwise
    M.append_tables_array(plugins, plug)
  end
end

---@return LazyPluginSpec[]
function M.get_plugins()
  return plugins
end

return M
