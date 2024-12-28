-- [[ Basic Keymaps ]]

-- wrapper for methode with arguments
local wrap = function(func, ...)
  local args = { ... }
  return function()
    func(unpack(args))
  end
end

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- moving wirh ctrl u ctrl d will put the cursor at the center of the screen
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- past from clipboard
-- if on windows
if string.find(vim.loop.os_uname().sysname, "NT") then
  vim.keymap.set("v", '<C-b>', '"*y')
  vim.keymap.set("n", '<C-b>', '"*p')
  vim.keymap.set("c", '<C-b>', '"*p')
else -- supposing linux system otherwise
  vim.keymap.set("v", '<C-b>', '"+y')
  vim.keymap.set("n", '<C-b>', '"+p')
  vim.keymap.set("c", '<C-b>', '"+p')
end

-- exit edit mode to go back to normal mode
vim.keymap.set({ 'n', 'i', 'v' }, '<C-c>', "<Esc>l")
vim.keymap.set({ 'n', 'i', 'v' }, '<C-f>', "<Esc>l")

-- Diagnostic keymaps
vim.keymap.set('n', '<A-j>', wrap(vim.diagnostic.jump, { count = 1, float = true }))
vim.keymap.set('n', '<A-k>', wrap(vim.diagnostic.jump, { count = -1, float = true }))
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)

-- Move line to start or end of top or bottom line
vim.keymap.set('n', 'dsk', '_d$k_i <Esc>pjddk_h<Del>')
vim.keymap.set('n', 'dxk', '_d$k$pjddk$')
vim.keymap.set('n', 'dsj', '_d$j_i <Esc>pkdd_h<Del>')
vim.keymap.set('n', 'dxj', '_d$j$pkdd$')

-- for multiline
for i = 1, 50 do
  vim.keymap.set('n', 'ds' .. i .. 'k', '_d$' .. i .. 'k_i <Esc>p' .. i .. 'jdd' .. i .. 'k_h<Del>')
  vim.keymap.set('n', 'dx' .. i .. 'k', '_d$' .. i .. 'k$p' .. i .. 'jdd' .. i .. 'k$')
  vim.keymap.set('n', 'ds' .. i .. 'j', '_d$' .. i .. 'j_i <Esc>p' .. i .. 'kdd' .. i - 1 .. 'j_h<Del>')
  vim.keymap.set('n', 'dx' .. i .. 'j', '_d$' .. i .. 'j$p' .. i .. 'kdd' .. i - 1 .. 'j$')
end

-- Move line top or bottom (switching with above or below line)
vim.keymap.set('n', '<A-K>', 'ddkkp')
vim.keymap.set('n', '<A-J>', 'ddp')

-- Visual mode block
vim.keymap.set('n', '<A-v>', '<C-v>')

-- Global marks
-- Go to mark (should follow with the mark letter)
vim.keymap.set('n', 'x', '`')
-- Delete all marks
vim.keymap.set('n', '<leader>dam', ':delm A-Z <CR>')

-- format on <A-l> or on save for supported file pattern
require("plugins.utils.format").format_activated_switch_set_key()
require("plugins.utils.format").format_vim_set_key()
require("plugins.utils.format").format_vim_autocmd()

local function set_runtime_path_to_luarc(runtime_paths)
  local luarc_paths = {}
  for i = 1, #runtime_paths do
    local path = runtime_paths[i]
    local lua_path = "\"" .. path .. "/lua\""
    if i ~= #runtime_paths then
      lua_path = lua_path .. ","
    end
    local unix_like_lua_path = string.gsub(lua_path, "\\", "/")
    luarc_paths[i] = unix_like_lua_path
  end
  return luarc_paths
end

-- it prints all luapaths at cursor position in the current buffer
-- to get luarc.json working properly with lua_ls on nvim configuration
-- you got to refresh it everytime you import a knew plugin if you
-- want to be able to have intellisense with lsp for that plugin
-- to do so go the .luarc.json file and remove everything inside
-- the library array then use this keymap to recreate the values
vim.keymap.set('n', '<leader>web', function()
  local runtime_paths = vim.api.nvim_list_runtime_paths()
  local unix_like_lua_paths = set_runtime_path_to_luarc(runtime_paths)
  local line_count = vim.api.nvim_buf_line_count(0)
  local row, _ = unpack(vim.api.nvim_win_get_cursor(0))
  vim.api.nvim_buf_set_lines(0, row - 1, row, false, unix_like_lua_paths)
end, { desc = "Append string to the end of the buffer" })
