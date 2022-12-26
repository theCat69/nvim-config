-- [[ Setting options ]]
-- See `:help vim.o`

-- Make line numbers default
vim.wo.number = true

-- Enable mouse mode
vim.o.mouse = 'a'

-- defining tabstop and shiftwidth
vim.opt.tabstop = 3
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.bo.softtabstop = 2

-- Enable break indent
vim.o.breakindent = true

-- Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Decrease update time
vim.o.updatetime = 250
vim.wo.signcolumn = 'yes'

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'
vim.opt.scrolloff = 8
vim.opt.incsearch = true
vim.opt.relativenumber = true

-- save undo
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})
-- vim.api.nvim_set_hl(0, "iCursor", { ctermbg = 0, fg = white, bg = blue })
-- vim.api.nvim_set_hl(0, "Cursor", { ctermbg = 0, guifg = white, guibg = green })
vim.opt.guicursor = "n-v-c-sm:block-Cursor,i-ci-ve:block-iCursor,r-cr-o:hor20"
