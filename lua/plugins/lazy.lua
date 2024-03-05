local lazy = require("lazy");
local lazy_utils = require("plugins.lazy-utils");

lazy.bootstrap()

lazy_utils.register_plugin(require("plugins.ui.theme"))
lazy_utils.register_plugin(require("ui.lualine"))
lazy_utils.register_plugin(require("plugins.ui.nvim-tree"))
lazy_utils.register_plugin(require("plugins.jumping.telescope"))
lazy_utils.register_plugin(require("plugins.ui.dropbar"))
lazy_utils.register_plugin(require("plugins.jumping.arrow"))
lazy_utils.register_plugin(require("plugins.git.git"))
lazy_utils.register_plugin(require("plugins.no-lsp.treesitter"))
lazy_utils.register_plugin(require("plugins.no-lsp.refactoring"))
lazy_utils.register_plugin(require("plugins.no-lsp.cmp"))
lazy_utils.register_plugin(require("plugins.no-lsp.misc"))

-- here i should get all the plugins and merge it here
require('lazy').setup(lazy_utils.get_plugins()
  {
    -- Package manager

    -- java painless plugin
    {
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
    },

    -- { -- LSP Configuration & Plugins
    --   'neovim/nvim-lspconfig',
    --   dependencies = {
    --     -- Automatically install LSPs to stdpath for neovim
    --     'williamboman/mason.nvim',
    --     'williamboman/mason-lspconfig.nvim',
    --     'mfussenegger/nvim-jdtls',
    --     'mfussenegger/nvim-dap',
    --     'theHamsta/nvim-dap-virtual-text',
    --     'rcarriga/nvim-dap-ui',
    --   },
    --   lazy = true,
    -- },

    -- a little plugin to update all mason packages
    { 'RubixDev/mason-update-all' },

    -- for debugging application if an UI
    {
      "rcarriga/nvim-dap-ui",
      dependencies = { "mfussenegger/nvim-dap" },
      lazy = true,
    },


    -- get doc for nvim lua code
    { "folke/neodev.nvim",        lazy = true },

    -- rust additional tools
    {
      'simrat39/rust-tools.nvim',
      lazy = true,
    },

    -- Jenkinsfile validation
    {
      "ckipp01/nvim-jenkinsfile-linter",
      lazy = true,
    },

    -- nginx
    {
      "chr4/nginx.vim",
      lazy = true,
    },

    -- nice ui for code actions
    {
      "aznhe21/actions-preview.nvim",
      config = function()
        vim.keymap.set({ "v", "n" }, "gt", require("actions-preview").code_actions)
      end,
      lazy = true,
    },


  }
)
