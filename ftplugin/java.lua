local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

local extendedClientCapabilities = require('jdtls').extendedClientCapabilities
extendedClientCapabilities.resolveAdditionalTextEditsSupport = true

local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
local workspace_dir = 'C:/dev/project/jdtls/' .. project_name
local jdtls_test_extension = 'C:/dev/editeur/jdtls-extension/'
local mason_jdtls = 'C:/Users/vadca/AppData/Local/nvim-data/mason/packages/jdtls/'

local bundles = {}

vim.list_extend(bundles,
  vim.split(vim.fn.glob(jdtls_test_extension ..
    'java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar'), "\n"))
vim.list_extend(bundles, vim.split(vim.fn.glob(jdtls_test_extension .. 'vscode-java-test/server/*.jar'), "\n"))

local java17 = "C:/dev/interpreteur_compilateur/Java/jdk-17.0.1"
local java11 = "C:/dev/interpreteur_compilateur/Java/jdk-11.0.12+7"
-- See `:help vim.lsp.start_client` for an overview of the supported `config` options.
local config = {
  -- The command that starts the language server
  -- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
  cmd = {

    java17 .. '/bin/java', -- or '/path/to/java17_or_newer/bin/java'
    -- depends on if `java` is in your $PATH env variable and if it points to the right version.

    '-Declipse.application=org.eclipse.jdt.ls.core.id1',
    '-Dosgi.bundles.defaultStartLevel=4',
    '-Declipse.product=org.eclipse.jdt.ls.core.product',
    '-Dlog.protocol=true',
    '-Dlog.level=ALL',
    '-Xms1g',
    '-Xmx2G',
    '-javaagent:' .. mason_jdtls .. 'lombok.jar',
    '--add-modules=ALL-SYSTEM',
    '--add-opens', 'java.base/java.util=ALL-UNNAMED',
    '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
    '-jar', mason_jdtls .. 'plugins/org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar',
    '-configuration', mason_jdtls .. 'config_win',
    '-data', workspace_dir,

  },

  init_options = {
    bundles = bundles,
  },

  on_attach = function(client, buffer)
    vim.lsp.codelens.refresh()
    require("jdtls.dap").setup_dap_main_class_configs()
    require('jdtls').setup_dap({ hotcodereplace = 'auto' })
    require('utils.lsp_utils').on_attach(client, buffer)
  end,

  root_dir = require('jdtls.setup').find_root({
    '.git', 'mvnw', 'gradlew', 'pom.xml',
    '.gitignore', '.gitattributes'
  }),

  capabilities = capabilities,

  settings = {
    java = {
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
      format = {
        enabled = true,
        settings = {
          url = os.getenv('DEV') .. '/project/jdtls/google-formatting-style/eclipse-java-google-style.xml',
        },
      },
      configuration = {
        updateBuildConfiguration = "interactive",
        runtimes = {
          {
            name = "JavaSE-17",
            path = java17,
          },
          {
            name = "JavaSE-11",
            path = java11,
          },
        }
      }
    },
    signatureHelp = { enabled = true },
    completion = {
      favoriteStaticMembers = {
        "org.mockito.Mockito.*",
      },
    },
    contentProvider = { preferred = "fernflower" },
    extendedClientCapabilities = extendedClientCapabilities,
    sources = {
      organizeImports = {
        starThreshold = 9999,
        staticStarThreshold = 9999,
      },
    },
    codeGeneration = {
      toString = {
        template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
      },
      useBlocks = true,
    },
  },

  flags = {
    allow_incremental_sync = true,
  },
}

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  pattern = { "*.java" },
  callback = function()
    local _, _ = pcall(vim.lsp.codelens.refresh)
  end,
})

require('jdtls').start_or_attach(config)
-- require("jdtls.setup").add_commands()

vim.cmd("command! -buffer -nargs=? -complete=custom,v:lua.require'jdtls'._complete_compile JdtCompile lua require('jdtls').compile(<f-args>)")
vim.cmd("command! -buffer -nargs=? -complete=custom,v:lua.require'jdtls'._complete_set_runtime JdtSetRuntime lua require('jdtls').set_runtime(<f-args>)")
vim.cmd("command! -buffer JdtUpdateConfig lua require('jdtls').update_project_config()")
vim.cmd("command! -buffer JdtJol lua require('jdtls').jol()")
vim.cmd("command! -buffer JdtBytecode lua require('jdtls').javap()")
vim.cmd("command! -buffer JdtJshell lua require('jdtls').jshell()")

local opts = { noremap = true, silent = true }
local map = vim.api.nvim_set_keymap

-- Refactor code
map('n', '<A-o>', "<Cmd>lua require('jdtls').organize_imports()<CR>", opts)

-- Code generateToString

-- local function set_configuration(settings)
--   vim.lsp.buf_request(0, "workspace/didChangeConfiguration", {
--     settings = settings,
--   }, function() end)
-- end
--
-- local function apply_edit(err, response)
--   if response then
--     local edit = response
--     if response.edit then
--       edit = response.edit
--     end
--     vim.lsp.util.apply_workspace_edit(edit, "utf-16")
--   elseif err then
--     vim.notify(vim.inspect(err), vim.log.levels.ERROR)
--   end
-- end
--
-- function generateConstructor(fields, params, optss)
--   if fields == nil then
--     vim.lsp.buf_request(0, "java/checkConstructorsStatus", vim.lsp.util.make_range_params(), function(err, resp)
--       if resp then
--         vim.fn["generators#GenerateConstructor"](resp.fields, resp.constructors, optss)
--       else
--         vim.notify(vim.inspect(err), vim.log.levels.ERROR)
--       end
--     end)
--   else
--     set_configuration({
--       ["java.codeGeneration.insertionLocation"] = "lastMember",
--     })
--
--     if params.default_constructor then
--       fields = {}
--     end
--     local context = vim.lsp.util.make_range_params()
--     context.context = {
--       diagnostics = {},
--       only = nil,
--     }
--     vim.lsp.buf_request(0, "java/generateConstructors", {
--       context = context,
--       fields = fields,
--       constructors = params.constructors,
--     }, apply_edit)
--   end
-- end
--
-- map('n', '<leader>gc', "<Cmd>lua generateConstructor(nil, nil, { default = false })<CR>", opts)

-- Test & debug
map('n', '<leader>tc', "<Cmd>lua require('jdtls').test_class()<CR>", opts)
map('n', '<leader>tm', "<Cmd>lua require('jdtls').test_nearest_method()<CR>", opts)

vim.api.nvim_create_autocmd('BufWritePre', {
  group = vim.api.nvim_create_augroup('onSaveEvent', { clear = true }),
  callback = function()
    vim.lsp.buf.format({ sync = true })
    require('jdtls').organize_imports()
  end,
})
