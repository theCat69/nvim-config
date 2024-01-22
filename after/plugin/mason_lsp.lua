-- neodev
require('neodev').setup()

-- Setup mason so it can manage external tooling
-- Ensure the servers above are installed
require('mason').setup()

-- Enable the following language servers
-- Feel free to add/remove any LSPs that you want here. They will automatically be installed
local servers = { 'clangd', 'rust_analyzer', 'pyright', 'tsserver', 'lua_ls', 'gopls', 'jdtls', 'yamlls', 'lemminx',
  'kotlin_language_server', 'html', 'cssls', 'bashls', 'jsonls', 'tailwindcss', 'groovyls', 'zls' }

require('mason-lspconfig').setup {
  ensure_installed = servers,
}

-- nvim-cmp supports additional completion capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

require('mason-lspconfig').setup_handlers {
  function(server_name) -- default handler (optional)
    require("lspconfig")[server_name].setup {
      on_attach = require('utils.lsp_utils').on_attach,
      capabilities = capabilities,
    }
  end,
  ["lua_ls"] = function()
    require("lspconfig")["lua_ls"].setup {
      on_attach = require('utils.lsp_utils').on_attach,
      capabilities = capabilities,
      settings = {
        diagnostics = {
          globals = {
            'require',
            'pcall',
          }
        }
      }
    }
  end,
  ["rust_analyzer"] = function()
    require("rust-tools").setup()
    require("lspconfig")["rust_analyzer"].setup {
      on_attach = require('utils.lsp_utils').on_attach,
      capabilities = capabilities,
      settings = {
        ['rust-analyzer'] = {
          cargo = {
            allFeatures = true,
          },
          diagnostics = { disabled = { "unresolved-proc-macro" } }
        }
      }
    }
  end,
  ["jdtls"] = function()
  end,
}

-- Turn on lsp status information
require('fidget').setup()
