local M = {}

function M.lsp_server_config()
  -- this will be run when an LSP attach to the buffer (replacing on_attach)
  -- the callback definition is in another file
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
    ["angularls"] = function()
      local root_directory = vim.fs.root(0, 'angular.json')
      if root_directory ~= nil
      then
        local cmd = {
          'ngserver',
          '--stdio',
          '--tsProbeLocations',
          root_directory .. '/node_modules/typescript/lib', -- need to point to project root then lib in project
          '--ngProbeLocations',
          root_directory .. '/node_modules/angular/language-service',
        }
        require("lspconfig")["angularls"].setup {
          capabilities = capabilities,
          cmd = cmd,
          on_new_config = function(new_config, new_root_dir)
            new_config.cmd = cmd
          end,
        }
      end
    end
  }

  -- configuring custom cairo
  if not require("lspconfig.configs").cairo then
    require("lspconfig.configs").cairo = {
      default_config = {
        cmd = { 'scarb', 'cairo-language-server' },
        filetypes = { 'cairo' },
        name = 'vscode-cairo',
        root_dir = require("lspconfig").util.root_pattern('Scarb.toml'),
      },
    }
  end

  require("lspconfig").cairo.setup({
    capabilities = capabilities,
  });
end

return M
