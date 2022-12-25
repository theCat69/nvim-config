-- format on save using lsp
vim.api.nvim_create_autocmd('BufWritePre', {
  group = vim.api.nvim_create_augroup('onSaveEvent', { clear = true }),
  pattern = { "*.rs", "*.ts", "*.tsx", "*.html", "*.css", "*.py", "*.xml", "*.json", "*.yml", "*.js", "*.lua" }, -- supported format on save
  callback = function()
    vim.lsp.buf.format({ sync = true })
  end,
})
