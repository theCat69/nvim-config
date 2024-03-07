---@type LazyPluginSpec
return {
  "David-Kunz/gen.nvim",
  cmd = { "Gen" },
  -- need ollaman to run
  cond = function()
    return vim.fn.executable('ollama') == 1
  end
}
