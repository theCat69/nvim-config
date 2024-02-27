vim.api.nvim_create_autocmd('BufWritePre', {
  group = vim.api.nvim_create_augroup('onSaveEventSolidity', { clear = true }),
  pattern = { "*.sol" }, -- supported format on save
  callback = function()
    require("utils.utils").format_basic_nvim()
  end,
})
