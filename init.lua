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

  { -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs to stdpath for neovim
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'mfussenegger/nvim-jdtls',
      'mfussenegger/nvim-dap',
      'theHamsta/nvim-dap-virtual-text',
      'rcarriga/nvim-dap-ui',
      -- Useful status updates for LSP
      { 'j-hui/fidget.nvim', tag = 'legacy' },
    },
    lazy = true,
  },

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


  { 'tpope/vim-fugitive', lazy = true },
  { 'tpope/vim-rhubarb',  lazy = true },

  -- adding signs at the left of the file to indicate
  -- git status of the line
  {
    'lewis6991/gitsigns.nvim',
    lazy = true,
  },

  'navarasu/onedark.nvim',     -- Theme inspired by Atom
  'nvim-lualine/lualine.nvim', -- Fancier statusline
  -- { 'lukas-reineke/indent-blankline.nvim', main = 'ibl',                              opts = {} }, -- Add indentation guides even on blank lines
  'numToStr/Comment.nvim',     -- "gc" to comment visual regions/lines

  -- Fuzzy Finder (files, lsp, etc)
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
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
  { "folke/neodev.nvim", lazy = true },

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

  -- to "hook" files with Ctrl + M and navigate with
  -- Ctrl + N and Ctrl + P
  {
    'ThePrimeagen/harpoon',
    branch = "harpoon2",
    dependencies = { { "nvim-lua/plenary.nvim" } },
    lazy = true,

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
  -- {
  --   "theCat69/actions-preview.nvim",
  --   config = function()
  --     vim.keymap.set({ "v", "n" }, "gt", require("actions-preview").code_actions)
  --   end,
  --   lazy = true,
  -- }
  {
     dir = 'C:\\dev\\editeur\\actions-preview.nvim' ,
    config = function()
      vim.keymap.set({ "v", "n" }, "gt", require("actions-preview").code_actions)
    end,
  },
})

require('custom')
