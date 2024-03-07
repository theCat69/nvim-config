-- filtypes to load all the lsp plugins
local ft = {
  "java", "lua", "sql", "rust", "xml", "json", "solidity", "typescript", "javascript", "html", "css",
  "python", "kotlin", "zig", "docker", "toml", "yaml", "c", "bash"
}

-- Enable the following language servers
-- Feel free to add/remove any LSPs that you want here.
-- servers automatically installed by mason
-- Those will inherit the default capabilities and on attach if not specificy otherwise
local servers = { 'clangd', 'rust_analyzer', 'pyright', 'tsserver', 'lua_ls', 'yamlls', 'lemminx',
  'kotlin_language_server', 'html', 'cssls', 'bashls', 'jsonls', 'tailwindcss', 'zls', 'dockerls', 'solidity_ls',
  'taplo' }
-- 'groovyls','gopls' => doesn't work didn't search why
-- 'jdtls' => installed via nvim-java

local function config()
  -- jdtls/java support
  require('java').setup()

  require('neodev').setup()

  require('mason-lspconfig').setup {
    ensure_installed = servers,
  }

  -- Here we specify default configuration for lsp servers
  -- and specific for some
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
    ft = ft,
    dependencies = {
      'nvim-java/lua-async-await',
      'nvim-java/nvim-java-core',
      'nvim-java/nvim-java-test',
      'nvim-java/nvim-java-dap',
      'MunifTanjim/nui.nvim',
      {
        "folke/neodev.nvim",
        library = { plugins = { "nvim-dap-ui" }, types = true },
        dependencies = {
          require("plugins.lsp.dap")
        }
      },
      { 'j-hui/fidget.nvim', tag = 'legacy' },
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
        }
      },
    }
  },
  -- rust additional tools
  {
    'simrat39/rust-tools.nvim',
    ft = "rust"
  },
  -- Jenkinsfile validation
  {
    "ckipp01/nvim-jenkinsfile-linter",
    ft = "groovy "
  },
  -- nginx
  {
    "chr4/nginx.vim",
    ft = "nginx"
  },
}
