vim.api.nvim_create_autocmd('BufWritePre', {
  group = vim.api.nvim_create_augroup('onSaveEventGroovy', { clear = true }),
  pattern = { "Jenkinsfile", "*.groovy" }, -- supported format on save
  callback = function()
    require("plugins.utils.format").format_vim()
    require("jenkinsfile_linter").validate()
  end,
})
