local M = {}

M.plugin = {
  'nvim-java/nvim-java',
  dependencies = {
    'nvim-java/lua-async-await',
    'nvim-java/nvim-java-core',
    'nvim-java/nvim-java-test',
    'nvim-java/nvim-java-dap',
    'MunifTanjim/nui.nvim',
    'neovim/nvim-lspconfig',
    'mfussenegger/nvim-dap',
    {
      'williamboman/mason.nvim',
      opts = {
        registries = {
          'github:nvim-java/mason-registry',
          'github:mason-org/mason-registry',
        }
      }
    },
    'williamboman/mason-lspconfig.nvim',
    --     -- Useful status updates for LSP
    { 'j-hui/fidget.nvim', tag = 'legacy' },
  }
}

function M.setup()
  require('java').setup()

  require('neodev').setup()
  -- Setup mason so it can manage external tooling
  -- Ensure the servers above are installed
  require('mason').setup()
  -- registries = {
  --   'github:nvim-java/mason-registry',
  --   'github:mason-org/mason-registry',
  -- }
  -- )


  -- Enable the following language servers
  -- Feel free to add/remove any LSPs that you want here. They will automatically be installed
  local servers = { 'clangd', 'rust_analyzer', 'pyright', 'tsserver', 'lua_ls', 'yamlls', 'lemminx',
    'kotlin_language_server', 'html', 'cssls', 'bashls', 'jsonls', 'tailwindcss', 'zls', 'dockerls', 'solidity_ls',
    'taplo' }
  -- 'groovyls','gopls','solidity','solidity_ls_nomicfoundation',
  -- 'jdtls' => installed via nvim-java i can't figure how to configure it

  require('mason-lspconfig').setup {
    ensure_installed = servers,
  }

  -- nvim-cmp supports additional completion capabilities
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

  require('lspconfig').jdtls.setup({
    on_attach = require('utils.lsp_utils').on_attach,
    capabilities = capabilities,
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
        on_attach = require('utils.lsp_utils').on_attach,
        capabilities = capabilities,
        cmd = { 'vscode-solidity-server', '--stdio' },
        filetypes = { 'solidity' },
      }
    end,
    -- doesn't work right now i need to check why or just continue to use intelliJ
    -- ["jdtls"] = function()
    --   local extendedClientCapabilities = require('jdtls').extendedClientCapabilities
    --   extendedClientCapabilities.resolveAdditionalTextEditsSupport = true
    --
    --   local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
    --   local workspace_dir = os.getenv('DEV') .. '/project/jdtls/' .. project_name
    --   local jdtls_test_extension = os.getenv('DEV') .. '/editeur/jdtls-extension/'
    --   local mason_jdtls = os.getenv('NVIM_DATA') .. '/mason/packages/jdtls/'
    --
    --   local bundles = {}
    --
    --   -- vim.list_extend(bundles,
    --   --   vim.split(vim.fn.glob(jdtls_test_extension ..
    --   --     'java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar'), "\n"))
    --   -- vim.list_extend(bundles, vim.split(vim.fn.glob(jdtls_test_extension .. 'vscode-java-test/server/*.jar'), "\n"))
    --
    --   require("lspcongif")["jdtls"].setup {
    --     on_attach = function(client, buffer)
    --       vim.lsp.codelens.refresh()
    --       require("jdtls.dap").setup_dap_main_class_configs()
    --       require('jdtls').setup_dap({ hotcodereplace = 'auto' })
    --       require('utils.lsp_utils').on_attach(client, buffer)
    --     end,
    --     capabilities = capabilities,
    --     settings = {
    --       java = {
    --         configuration = {
    --           runtimes = {
    --             {
    --               name = "JavaSE-21",
    --               path = os.getenv("JAVA_RUNTIMES") .. "/jdk-21.0.1",
    --               default = true,
    --             },
    --             {
    --               name = "JavaSE-17",
    --               path = os.getenv("JAVA_RUNTIMES") .. "/jdk-17.0.1",
    --             },
    --             {
    --               name = "JavaSE-11",
    --               path = os.getenv("JAVA_RUNTIMES") .. "/jdk-11.0.12+7",
    --             },
    --           },
    --           eclipse = {
    --             downloadSources = true,
    --           },
    --           maven = {
    --             downloadSources = true,
    --           },
    --           implementationsCodeLens = {
    --             enabled = true,
    --           },
    --           referencesCodeLens = {
    --             enabled = true,
    --           },
    --           references = {
    --             includeDecompiledSources = true,
    --           },
    --           inlayHints = {
    --             parameterNames = {
    --               enabled = "all", -- literals, all, none
    --             },
    --           },
    --           format = {
    --             enabled = true,
    --             settings = {
    --               url = os.getenv('DEV') .. '/project/jdtls/google-formatting-style/eclipse-java-google-style.xml',
    --             },
    --           },
    --           signatureHelp = { enabled = true },
    --           completion = {
    --             favoriteStaticMembers = {
    --               "org.mockito.Mockito.*",
    --             },
    --           },
    --           contentProvider = { preferred = "fernflower" },
    --           extendedClientCapabilities = extendedClientCapabilities,
    --           sources = {
    --             organizeImports = {
    --               starThreshold = 9999,
    --               staticStarThreshold = 9999,
    --             },
    --           },
    --           codeGeneration = {
    --             toString = {
    --               template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
    --             },
    --             useBlocks = true,
    --           },
    --           flags = {
    --             allow_incremental_sync = true,
    --           },
    --         },
    --       }
    --     },
    --     -- init_options = {
    --     --   bundles = bundles,
    --     -- },
    --   }
    -- end,
  }

  -- Turn on lsp status information
  require('fidget').setup()

  -- Simple command to update all packages
  require('mason-update-all').setup()
end