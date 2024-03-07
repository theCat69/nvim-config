-- Enable Comment.nvim
-- "gc" to comment visual regions/lines

local function config_comment()
  require('Comment').setup()
end

local function config_autopairs()
  require("nvim-autopairs").setup({})
end

---@type LazyPluginSpec[]
return {
  {
    'numToStr/Comment.nvim',
    keys = { "gc" },
    config = config_comment,
  },
  {
    "windwp/nvim-autopairs",
    config = config_autopairs,
  },
}
