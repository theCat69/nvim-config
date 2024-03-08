---@type LazyPluginSpec
return {
  "David-Kunz/gen.nvim",
  cmd = { "Gen" },
  -- i will have to check on windows if it works as well
  opts = {
    display_mode = "split",
  },
  -- need ollaman to run
  cond = function()
    return vim.fn.executable('ollama') == 1
  end
}
