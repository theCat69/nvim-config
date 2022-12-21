vim.opt_local.cmdheight = 2 -- more space in the neovim command line for displaying messages

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

local extendedClientCapabilities = require('jdtls').extendedClientCapabilities
extendedClientCapabilities.resolveAdditionalTextEditsSupport = true

local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
local workspace_dir = 'C:/dev/project/jdtls/' .. project_name
local jdtls_test_extension = 'C:/dev/editeur/jdtls-extension/'
local mason_jdtls = 'C:/Users/vadca/AppData/Local/nvim-data/mason/packages/jdtls/'

local bundles = {}

vim.list_extend(bundles, vim.split(vim.fn.glob(jdtls_test_extension .. 'java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar'), "\n"))
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
    require('lib.nmap_lsp').on_attach(client, buffer)
    require("jdtls.dap").setup_dap_main_class_configs()
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
        enabled = false,
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

require('jdtls').start_or_attach(config)
require('jdtls').setup_dap({ hotcodereplace = 'auto' })
require("jdtls.setup").add_commands()

--[[ require('dap').configurations.java = {{
  projectName = project_name,
  javaExec = java17,
  mainClass = "com.fef.springboot.actuator.Application",
}} --]]

vim.cmd("command! -buffer -nargs=? -complete=custom,v:lua.require'jdtls'._complete_compile JdtCompile lua require('jdtls').compile(<f-args>)")
vim.cmd("command! -buffer -nargs=? -complete=custom,v:lua.require'jdtls'._complete_set_runtime JdtSetRuntime lua require('jdtls').set_runtime(<f-args>)")
vim.cmd("command! -buffer JdtUpdateConfig lua require('jdtls').update_project_config()")
-- vim.cmd "command! -buffer JdtJol lua require('jdtls').jol()"
vim.cmd("command! -buffer JdtBytecode lua require('jdtls').javap()")
-- vim.cmd "command! -buffer JdtJshell lua require('jdtls').jshell()"

local opts = { noremap = true, silent = true }
local map = vim.api.nvim_set_keymap

--[[ this is not working right now because jtls is using java in path to compile 
-- but test are run using configured runtimes 
-- map('n', 'gB', "<Cmd>lua require('jdtls').compile('full')<CR>", opts)
--]]

map('n', 'gT', "<Cmd>lua require('jdtls').test_class()<CR>", opts)
map('n', 'gB', "<Cmd>lua require('dap').continue()<CR>", opts)
map('n', 'gC', "<Cmd>lua require('dap').terminate()<CR>", opts)
