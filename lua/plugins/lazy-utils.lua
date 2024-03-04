local table_utils = require("lua-config-common.table-utils")

local M = {}

local function unpack_custom_plugin(plug, ...)
  local args = { ... };
  return {
    table.unpack(plug.plugin),
    config = function()
      plug.setup(table.unpack(args));
    end,
    lazy = plug.lazy
  }
end

function M.register_custom_plugins(plugs)
  local plugin_conf = {}
  for _, plug in plugs do
    local unpacked_plugin = {}

    if plug[2] ~= nil then
      unpacked_plugin = unpack_custom_plugin(plug[1], table.unpack(plug[2]))
    else
      unpacked_plugin = unpack_custom_plugin(plug[1])
    end

    table.insert(plugin_conf, unpacked_plugin)
  end
  return plugin_conf
end

return M
