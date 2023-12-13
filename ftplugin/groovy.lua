-- local capabilities = vim.lsp.protocol.make_client_capabilities()
-- capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
--
-- require('lspconfig')['groovyls'].setup {
--   capabilities = capabilities,
--   cmd = { 'java', '-jar', os.getenv('NVIM_DATA') .. '/mason/packages/groovy-language-server/build/libs/groovy-language-server-all.jar' },
--   filetypes = {
--     "groovy",
--   },
-- }

vim.keymap.set('n', '<A-l>', 'mj gg=G `j')

vim.api.nvim_create_autocmd('BufWritePre', {
  group = vim.api.nvim_create_augroup('onSaveEventGroovy', { clear = true }),
  pattern = { "Jenkinsfile", "*.groovy" }, -- supported format on save
  callback = function()
    -- vim.api.nvim_input('<A-l>')
    require("jenkinsfile_linter").validate()
  end,
})
