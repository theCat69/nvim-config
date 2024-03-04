-- Enable Comment.nvim
-- "gc" to comment visual regions/lines

local M = {}

M.lazy = true

M.plugin = {
  'numToStr/Comment.nvim'
}

function M.setup()
  require('Comment').setup()
end

return M
