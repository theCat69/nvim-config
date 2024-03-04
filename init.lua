-- require("before")
-- require("plugins.lazy")

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

-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

require('lazy').setup({
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

  {
    "L3MON4D3/LuaSnip",
    dependencies = { "theCat69/friendly-snippets" },
  },

  { -- Autocompletion
    'hrsh7th/nvim-cmp',
    dependencies = { 'hrsh7th/cmp-nvim-lsp', 'L3MON4D3/LuaSnip', 'saadparwaiz1/cmp_luasnip'
    },
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


  { 'tpope/vim-fugitive' },
  { 'tpope/vim-rhubarb' },

  -- adding signs at the left of the file to indicate
  -- git status of the line
  {
    'lewis6991/gitsigns.nvim',
    lazy = true,
  },

  -- themes
  -- { "savq/melange-nvim" },
  { 'morhetz/gruvbox' },
  -- {
  --   'projekt0n/github-nvim-theme',
  --   lazy = false,    -- make sure we load this during startup if it is your main colorscheme
  --   priority = 1000, -- make sure to load this before all the other start plugins
  -- },
  -- { 'rakr/vim-one' },              -- Theme inspired by Atom (light or dark theme)
  -- { 'navarasu/onedark.nvim' },     -- Theme inspired by Atom (dark theme)
  { 'nvim-lualine/lualine.nvim' }, -- Fancier statusline
  { 'numToStr/Comment.nvim' },     -- "gc" to comment visual regions/lines

  -- Fuzzy Finder (files, lsp, etc)
  {
    'nvim-telescope/telescope.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    lazy = true,
  },

  -- Fuzzy Finder Algorithm which dependencies local dependencies to be built. Only load if `make` is available
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'make',
    cond = vim.fn.executable 'make' == 1,
    lazy = true,
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

  -- a replacement for harpoon
  { "otavioschwanck/arrow.nvim" },

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

  -- drop bar insane shit
  {
    'Bekaboo/dropbar.nvim',
    -- optional, but required for fuzzy finder support
    dependencies = {
      'nvim-telescope/telescope-fzf-native.nvim'
    }
  },

})

require('custom')
