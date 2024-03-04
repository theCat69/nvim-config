local M = {}

local format_key_binding = "<A-l>"
local format_vim_input = "mugg=Gxu"

local function format_lsp()
  vim.lsp.buf.format({ sync = true })
end

local function format_vim()
  vim.api.nvim_input(format_vim_input)
end

function M.format_vim_set_key()
  vim.keymap.set("n", format_key_binding, format_vim_input)
end

function M.format_lsp_set_key()
  vim.keymap.set("n", format_key_binding, format_lsp)
end

function M.format_lsp_autocmd()
  -- format on save using lsp
  vim.api.nvim_create_autocmd('BufWritePre', {
    group = vim.api.nvim_create_augroup('onSaveEvent', { clear = true }),
    pattern = { "*.rs", "*.ts", "*.tsx", "*.html", "*.css", "*.py", "*.xml", "*.json", "*.yml", "*.js", "*.lua" }, -- supported format on save
    callback = format_lsp,
  })
end

function M.format_vim_autocmd()
  -- format on save using vim (possibly treesitter)
  vim.api.nvim_create_autocmd('BufWritePre', {
    group = vim.api.nvim_create_augroup('onSaveEventSolidity', { clear = true }),
    pattern = { "*.sol" }, -- supported format on save
    callback = format_vim,
  })
end

return M
