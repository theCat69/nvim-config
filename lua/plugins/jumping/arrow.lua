-- a replacement for harpoon
local M = {}

M.lazy = true

M.plugin = {
  "otavioschwanck/arrow.nvim"
}

function M.setup()
  require('arrow').setup({
    show_icons = true,
    leader_key = ';', -- Recommended to be a single key
    window = {        -- controls the appearance and position of an arrow window (see nvim_open_win() for all options)
      width = 50,
      height = "auto",
      row = "auto",
      col = "auto",
      border = "double",
    }
  })
end

return M
