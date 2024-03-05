local function config()
  -- jdtls support
  require('java').setup()

  require('neodev').setup()
  -- Setup mason so it can manage external tooling
  -- Ensure the servers above are installed

  -- Enable the following language servers
  -- Feel free to add/remove any LSPs that you want here. They will automatically be installed
  -- Those will inherit the default capabilities and on attach
  local servers = { 'clangd', 'rust_analyzer', 'pyright', 'tsserver', 'lua_ls', 'yamlls', 'lemminx',
    'kotlin_language_server', 'html', 'cssls', 'bashls', 'jsonls', 'tailwindcss', 'zls', 'dockerls', 'solidity_ls',
    'taplo' }
  -- 'groovyls','gopls' => doesn't work didn't search why
  -- 'jdtls' => installed via nvim-java

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
      'mfussenegger/nvim-dap',
      {
        'neovim/nvim-lspconfig',
        dependencies = {
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
          'RubixDev/mason-update-all',
          "folke/neodev.nvim"
        }
      },
      { 'j-hui/fidget.nvim', tag = 'legacy' },
      -- rust additional tools
      'simrat39/rust-tools.nvim'
    }
  },

  -- Jenkinsfile validation
  {
    "ckipp01/nvim-jenkinsfile-linter",
  },

  -- nginx
  {
    "chr4/nginx.vim",
  },
}
