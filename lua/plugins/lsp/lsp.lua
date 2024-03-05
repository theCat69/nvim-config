local function config()
  require('java').setup()

  require('neodev').setup()
  -- Setup mason so it can manage external tooling
  -- Ensure the servers above are installed
  require('mason').setup()

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

  require("plugins.lsp.lsp-server-config").lsp_server_config()

  -- Turn on lsp status information
  require('fidget').setup()

  -- Simple command to update all packages
  require('mason-update-all').setup()
end

---@type LazyPluginSpec[]
return {
  {
    'nvim-java/nvim-java',
    config = config,
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
      {
        'RubixDev/mason-update-all',
        lazy = true
      },
      {
        "folke/neodev.nvim",
      },
      -- rust additional tools
      {
        'simrat39/rust-tools.nvim',
      },
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

  -- for debugging application if an UI
  -- {
  --   "rcarriga/nvim-dap-ui",
  --   dependencies = { "mfussenegger/nvim-dap" },
  --   lazy = true,
  -- },

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
}
