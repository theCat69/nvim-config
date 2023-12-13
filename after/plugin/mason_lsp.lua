-- neodev
require('neodev').setup()

-- Setup mason so it can manage external tooling
-- Ensure the servers above are installed
require('mason').setup()

-- Enable the following language servers
-- Feel free to add/remove any LSPs that you want here. They will automatically be installed
local servers = { 'clangd', 'rust_analyzer', 'pyright', 'tsserver', 'lua_ls', 'gopls', 'jdtls', 'yamlls', 'lemminx',
  'kotlin_language_server', 'html', 'cssls', 'bashls', 'jsonls', 'tailwindcss', 'groovyls' }

require('mason-lspconfig').setup {
  ensure_installed = servers,
}

-- nvim-cmp supports additional completion capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

for _, lsp in ipairs(servers) do
  if (lsp ~= 'jdtls') then
    require('lspconfig')[lsp].setup {
      on_attach = require('utils.lsp_utils').on_attach,
      capabilities = capabilities,
      settings = {
        Lua = {
          diagnostics = {
            globals = {
              'require',
              'pcall',
            }
          }
        }
      }
    }
  end
end

-- Turn on lsp status information
require('fidget').setup()
