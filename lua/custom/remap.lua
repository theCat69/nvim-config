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
vim.keymap.set("v", '<C-b>', '"*y')
vim.keymap.set("n", '<C-b>', '"*p')
vim.keymap.set("c", '<C-b>', '"*p')
-- exit edit mode to go back to normal mode
vim.keymap.set({ 'n', 'i', 'v' }, '<C-c>', "<Esc>l")
vim.keymap.set({ 'n', 'i', 'v' }, '<C-f>', "<Esc>l")

-- Diagnostic keymaps
vim.keymap.set('n', '<A-k>', vim.diagnostic.goto_prev)
vim.keymap.set('n', '<A-j>', vim.diagnostic.goto_next)
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)

-- Move line to start or end of top or bottom line
-- i dont know why, on the first remap, the h makes me delete the line if i try to move to empty line
-- but when i type it myself it works perfectly
vim.keymap.set('n', 'dsk', '^^d$k^^i <Esc>pjddk^^h<Del>')
vim.keymap.set('n', 'dxk', '^^d$k$pjddk$')
vim.keymap.set('n', 'dsj', '^^d$j^^i <Esc>pkdd^^h<Del>')
vim.keymap.set('n', 'dxj', '^^d$j$pkdd$')

-- for multiline
for i = 1, 50 do
  vim.keymap.set('n', 'ds' .. i .. 'k', '^^d$' .. i .. 'k^^i <Esc>p' .. i .. 'jdd' .. i .. 'k^^h<Del>')
  vim.keymap.set('n', 'dx' .. i .. 'k', '^^d$' .. i .. 'k$p' .. i .. 'jdd' .. i .. 'k$')
  vim.keymap.set('n', 'ds' .. i .. 'j', '^^d$' .. i .. 'j^^i <Esc>p' .. i .. 'kdd' .. i - 1 .. 'j^^h<Del>')
  vim.keymap.set('n', 'dx' .. i .. 'j', '^^d$' .. i .. 'j$p' .. i .. 'kdd' .. i - 1 .. 'j$')
end

-- Move line top or bottom (switching with above or below line)
vim.keymap.set('n', '<A-K>', 'ddkkp')
vim.keymap.set('n', '<A-J>', 'ddp')
