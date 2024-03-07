---Helper to integrate my files into lazy setup for plugins
---@class LazyUtils
local M = {}

local plugins = {}

function M.append_table_array(tab, tab_to_append)
  for _, v in ipairs(tab_to_append) do
    table.insert(tab, v)
  end
end

---Register one or more plugins
---@param plug LazyPluginSpec[] array of lazy plugins
function M.register_plugin(plug)
  M.append_table_array(plugins, plug)
end

---@return LazyPluginSpec[]
function M.get_plugins()
  return plugins
end

return M
