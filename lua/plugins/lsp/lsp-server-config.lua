local M = {}

function M.lsp_server_config()
  -- this will be run when an LSP attach to the buffer (replacing on_attach)
  vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('fefou-lsp-attach', { clear = true }),
    callback = require('plugins.utils.lsp').on_attach
  })

  -- nvim-cmp supports additional completion capabilities
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

  -- setup mason handle LSPs (everything but jdtls)
  require('mason-lspconfig').setup_handlers {
    function(server_name) -- default handler (optional)
      require("lspconfig")[server_name].setup {
        capabilities = capabilities,
      }
    end,
    ["lua_ls"] = function()
      require("lspconfig")["lua_ls"].setup {
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
        capabilities = capabilities,
        settings = {
          ['rust-analyzer'] = {
            cargo = {
              allFeatures = true,
            },
            -- diagnostics = { disabled = { "unresolved-proc-macro" } },
            checkOnSave = {
              command = "clippy",
            },
          }
        }
      }
    end,
    ["solidity_ls"] = function()
      require("lspconfig")["solidity"].setup {
        capabilities = capabilities,
        cmd = { 'vscode-solidity-server', '--stdio' },
        filetypes = { 'solidity' },
      }
    end,
  }

  -- setup jdtls specifically
  require('lspconfig').jdtls.setup({
    capabilities = capabilities,
    -- i should define root dir because otherwise
    -- he is very slow to find it
    -- root_dir = require('jdtls.setup').find_root({
    --   '.git', 'mvnw', 'gradlew', 'pom.xml',
    --   '.gitignore', '.gitattributes'
    -- }),
    settings = {
      java = {
        configuration = {
          runtimes = {
            {
              name = "JavaSE-21",
              path = os.getenv("JAVA_RUNTIMES") .. "/jdk-21.0.1",
              default = true,
            },
            {
              name = "JavaSE-17",
              path = os.getenv("JAVA_RUNTIMES") .. "/jdk-17.0.1",
            },
            {
              name = "JavaSE-11",
              path = os.getenv("JAVA_RUNTIMES") .. "/jdk-11.0.12+7",
            },
          },
          eclipse = {
            downloadSources = true,
          },
          maven = {
            downloadSources = true,
          },
          implementationsCodeLens = {
            enabled = true,
          },
          referencesCodeLens = {
            enabled = true,
          },
          references = {
            includeDecompiledSources = true,
          },
          inlayHints = {
            parameterNames = {
              enabled = "all", -- literals, all, none
            },
          },
          flags = {
            allow_incremental_sync = true,
          },
          signatureHelp = { enabled = true },
        }
      },
    }
  })
end

return M
