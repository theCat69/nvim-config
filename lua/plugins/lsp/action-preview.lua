local function config()
  -- handling theme switch between dark and light
  local theme = require("plugins.ui.theme-metadata").theme
  local delta_string_theme = ""
  if theme == "light" then
    delta_string_theme = " --light --syntax-theme GitHub"
  end

  require("actions-preview").setup {
    telescope = {
      sorting_strategy = "ascending",
      layout_strategy = "vertical",
      layout_config = {
        width = 0.9,
        height = 0.95,
        prompt_position = "top",
        preview_cutoff = 20,
        preview_height = function(_, _, max_lines)
          return max_lines - 15
        end,
      },
    },
    highlight_command = {
      require("actions-preview.highlight").delta("delta --no-gitconfig --side-by-side --file-style 'omit'" .. delta_string_theme),
    }
  }
  vim.keymap.set({ "v", "n" }, "gt", require("actions-preview").code_actions)
end

---@type LazyPluginSpec[]
return {
  {
    "aznhe21/actions-preview.nvim",
    config = config,
  }
}
