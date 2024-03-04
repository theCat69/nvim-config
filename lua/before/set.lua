-- [[ Setting options ]]
-- See `:help vim.o`
--
-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '

vim.g.maplocalleader = ' '
-- Make line numbers default
vim.wo.number = true

-- Enable mouse mode
vim.o.mouse = 'a'

-- defining tabstop and shiftwidth
vim.opt.tabstop = 2
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

-- cursor change color when mode change and blinking insert cursor
vim.api.nvim_set_hl(0, "iCursor", { fg = '#00BFFF', bg = '#00BFFF' })
vim.api.nvim_set_hl(0, "vCursor", { fg = '#EE82EE', bg = '#EE82EE' })
vim.api.nvim_set_hl(0, "Cursor", { fg = '#90EE90', bg = '#90EE90' })
vim.opt.guicursor =
"n-c-sm:block-Cursor,v:block-vCursor,i-ci-ve:block-iCursor-blinkwait500-blinkoff200-blinkon500,r-cr-o:hor20"

-- checking if we are on windows we use powershell as the embeded neovim shell
-- this is because cmd got compatibility issues with the termopen function
-- that write the output of a command to an embeded untouch embeded terminal
if string.find(vim.loop.os_uname().sysname, "NT") then
  vim.opt.shell = "powershell"
  vim.opt.shellcmdflag = "-command"
  vim.opt.shellquote = "\""
  vim.opt.shellxquote = ""
end
