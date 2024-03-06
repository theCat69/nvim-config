-- [[ Basic Keymaps ]]

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
vim.keymap.set('n', '<A-k>', vim.diagnostic.goto_prev)
vim.keymap.set('n', '<A-j>', vim.diagnostic.goto_next)
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
require("plugins.utils.format").format_vim_set_key()
require("plugins.utils.format").format_vim_autocmd()
