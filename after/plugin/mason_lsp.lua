-- Setup mason so it can manage external tooling
require('mason').setup()

-- Enable the following language servers
-- Feel free to add/remove any LSPs that you want here. They will automatically be installed
local servers = { 'clangd', 'rust_analyzer', 'pyright', 'tsserver', 'sumneko_lua', 'gopls', 'jdtls', 'yamlls', 'lemminx',
  'kotlin_language_server', 'html', 'cssls' }

-- Ensure the servers above are installed
require('mason-lspconfig').setup {
  ensure_installed = servers,
}

-- nvim-cmp supports additional completion capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

for _, lsp in ipairs(servers) do
  if (lsp ~= 'jdtls') then
    require('lspconfig')[lsp].setup {
      on_attach = require('lib.nmap_lsp').on_attach,
      capabilities = capabilities,
    }
  end
end

--       diagnostics = {
--         globals = { 'vim' },
--       },
--       workspace = { library = vim.api.nvim_get_runtime_file('', true) },
--       -- Do not send telemetry data containing a randomized but unique identifier
--       telemetry = { enable = false },
--     },
--   },
-- }

-- Turn on lsp status information
require('fidget').setup()
