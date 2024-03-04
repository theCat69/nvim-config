local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- here i should get all the plugins and merge it here
require('lazy').setup(
  require("plugins.lazy-utils").register_custom_plugins({
    { require("plugins.ui.theme"),         { "light" } },
    { require("plugins.ui.lualine") },
    { require("plugins.ui.nvim-tree") },
    { require("plugins.jumping.telescope") },
    { require("plugins.ui.dropbar") },
    { require("plugins.jumping.arrow") },
    { require("plugins.git.git") },
    { require("plugins.no-lsp.cmp") },
    { require("plugins.no-lsp.comment") }
  })
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

    { -- Highlight, edit, and navigate code
      'nvim-treesitter/nvim-treesitter',
      build = function()
        pcall(require('nvim-treesitter.install').update { with_sync = true })
      end,
      dependencies = {
        'nvim-treesitter/nvim-treesitter-textobjects',
      },
    },



    {
      "windwp/nvim-autopairs",
      config = function() require("nvim-autopairs").setup {} end,
    },

    -- get doc for nvim lua code
    { "folke/neodev.nvim",        lazy = true },

    -- just to get a nice file tree like in any code editors
    -- it can slow down startup a lot on low spec device
    {
      'nvim-tree/nvim-tree.lua',
      dependencies = {
        'nvim-tree/nvim-web-devicons',
      },
      lazy = true,
    },

    -- refactoring good for typescript
    {
      "ThePrimeagen/refactoring.nvim",
      dependencies = {
        { "nvim-lua/plenary.nvim" },
        { "nvim-treesitter/nvim-treesitter" }
      },
    },


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
