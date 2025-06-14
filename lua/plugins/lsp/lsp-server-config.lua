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

  vim.lsp.config('lua_ls', {
    on_init = function(client)
      if client.workspace_folders then
        local path = client.workspace_folders[1].name
        if
            path ~= vim.fn.stdpath('config')
            and (vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc'))
        then
          return
        end
      end

      client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
        runtime = {
          -- Tell the language server which version of Lua you're using (most
          -- likely LuaJIT in the case of Neovim)
          version = 'LuaJIT',
          -- Tell the language server how to find Lua modules same way as Neovim
          -- (see `:h lua-module-load`)
          path = {
            'lua/?.lua',
            'lua/?/init.lua',
          },
        },
        -- Make the server aware of Neovim runtime files
        workspace = {
          checkThirdParty = false,
          library = {
            vim.env.VIMRUNTIME
            -- Depending on the usage, you might want to add additional paths
            -- here.
            -- '${3rd}/luv/library'
            -- '${3rd}/busted/library'
          }
          -- Or pull in all of 'runtimepath'.
          -- NOTE: this is a lot slower and will cause issues when working on
          -- your own configuration.
          -- See https://github.com/neovim/nvim-lspconfig/issues/3189
          -- library = {
          --   vim.api.nvim_get_runtime_file('', true),
          -- }
        }
      })
    end,
    settings = {
      Lua = {}
    }
  })

  -- setup mason handle LSPs (everything but jdtls)
  -- require('mason-lspconfig').setup_handlers {
  --   function(server_name) -- default handler (optional)
  --     require("lspconfig")[server_name].setup {
  --       capabilities = capabilities,
  --     }
  --   end,
  --   ["lua_ls"] = function()
  --     require("lspconfig")["lua_ls"].setup {
  --       capabilities = capabilities,
  --       settings = {
  --         diagnostics = {
  --           globals = {
  --             'require',
  --             'pcall',
  --           }
  --         }
  --       }
  --     }
  --   end,
  --   ["rust_analyzer"] = function()
  --     require("rust-tools").setup()
  --     require("lspconfig")["rust_analyzer"].setup {
  --       capabilities = capabilities,
  --       settings = {
  --         ['rust-analyzer'] = {
  --           cargo = {
  --             allFeatures = true,
  --           },
  --           -- diagnostics = { disabled = { "unresolved-proc-macro" } },
  --           checkOnSave = {
  --             command = "clippy",
  --           },
  --         }
  --       }
  --     }
  --   end,
  --   ["solidity_ls"] = function()
  --     require("lspconfig")["solidity"].setup {
  --       capabilities = capabilities,
  --       cmd = { 'vscode-solidity-server', '--stdio' },
  --       filetypes = { 'solidity' },
  --     }
  --   end,
  --   ["angularls"] = function()
  --     local root_directory = vim.fs.root(0, 'angular.json')
  --     if root_directory ~= nil
  --     then
  --       local cmd = {
  --         'ngserver',
  --         '--stdio',
  --         '--tsProbeLocations',
  --         root_directory .. '/node_modules/typescript/lib', -- need to point to project root then lib in project
  --         '--ngProbeLocations',
  --         root_directory .. '/node_modules/angular/language-service',
  --       }
  --       require("lspconfig")["angularls"].setup {
  --         capabilities = capabilities,
  --         cmd = cmd,
  --         on_new_config = function(new_config, new_root_dir)
  --           new_config.cmd = cmd
  --         end,
  --       }
  --     end
  --   end
  -- }
  --
end

return M
