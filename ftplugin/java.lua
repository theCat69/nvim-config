-- doesn't work right now i need to check why or just continue to use intelliJ
-- this was moved to lsp config in plugins folder
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
--       require('plugins.utils.lsp').on_attach(client, buffer)
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
