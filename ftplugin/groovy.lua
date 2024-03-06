-- specific jenkins file things
vim.api.nvim_create_autocmd('BufWritePre', {
  group = vim.api.nvim_create_augroup('onSaveEventJenkins', { clear = true }),
  pattern = { "Jenkinsfile" }, -- supported format on save
  callback = function()
    require("plugins.utils.format").format_vim()
    require("jenkinsfile_linter").validate()
  end,
})
