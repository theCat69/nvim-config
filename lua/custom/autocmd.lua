vim.api.nvim_create_autocmd('BufWritePre', {
  group = vim.api.nvim_create_augroup('onSaveEvent', { clear = true }),
  callback = function()
    vim.lsp.buf.format({ sync = true })
  end,
})
