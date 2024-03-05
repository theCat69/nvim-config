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
    config = config_comment,
    lazy = true
  },
  {
    "windwp/nvim-autopairs",
    config = config_autopairs,
    lazy = true
  },
}
