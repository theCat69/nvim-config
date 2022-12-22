vim.api.nvim_create_autocmd('BufWritePre', {
  group = vim.api.nvim_create_augroup('onSaveEvent', { clear = true }),
  pattern = { "*.ts", "*.html", "*.css", "*.py", "*.xml", "*.yml", "*.js", "*.lua" }, -- supported format on save
  callback = function()
    vim.lsp.buf.format({ sync = true })
  end,
})
