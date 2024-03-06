-- a replacement for harpoon
local function config()
  require('arrow').setup({
    show_icons = true,
    leader_key = ';', -- Recommended to be a single key
    window = {        -- controls the appearance and position of an arrow window (see nvim_open_win() for all options)
      width = 50,
      height = "auto",
      row = "auto",
      col = "auto",
      border = "double",
    },
    index_keys = "azertyuiopAZERTYUIOP123456789"
  })
end

---@type LazyPluginSpec[]
return {
  {
    "otavioschwanck/arrow.nvim",
    config = config
  }
}
