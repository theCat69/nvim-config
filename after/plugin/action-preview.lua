local hl = require("actions-preview.highlight")

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
    hl.delta("delta --no-gitconfig --side-by-side"),
    -- options i tried : --grep-output-type classic
  }
}
