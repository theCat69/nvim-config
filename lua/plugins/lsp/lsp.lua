-- filtypes to load all the lsp plugins
local ft = {
  "java", "lua", "sql", "rust", "xml", "json", "solidity", "typescript", "javascript", "html", "css",
  "python", "kotlin", "zig", "docker", "toml", "yaml", "c", "bash", "cairo", "go"
}

-- cmd that trigger the load of all lsp plugins
local cmd = { "MasonUpdate", "MasonUpdateAll" }

-- Enable the following language servers
-- Feel free to add/remove any LSPs that you want here.
-- servers automatically installed by mason
-- Those will inherit the default capabilities and on attach if not specificy otherwise
local servers = { 'clangd', 'rust_analyzer', 'pyright', 'lua_ls', 'yamlls', 'lemminx',
  'kotlin_language_server', 'html', 'cssls', 'bashls', 'jsonls', 'tailwindcss', 'zls', 'dockerls', 'solidity_ls',
  'taplo', 'gopls' }
-- 'jdtls' => installed via nvim-java

local function config()
  -- jdtls/java support
  require('java').setup()

  require('neodev').setup({
    library = { plugins = { "nvim-dap-ui" }, types = true },
  })

  require('mason-lspconfig').setup {
    ensure_installed = servers,
  }

  -- Here we specify default configuration for lsp servers
  -- and specific for some
  require("plugins.lsp.lsp-server-config").lsp_server_config()

  -- Simple command to update all packages
  require('mason-update-all').setup()
end

---@type LazyPluginSpec[]
return {
  {
    'nvim-java/nvim-java',
    config = config,
    ft = ft,
    cmd = cmd,
    dependencies = {
      'nvim-java/lua-async-await',
      'nvim-java/nvim-java-core',
      'nvim-java/nvim-java-test',
      'nvim-java/nvim-java-dap',
      'MunifTanjim/nui.nvim',
      {
        "folke/neodev.nvim",
        dependencies = {
          require("plugins.lsp.dap")
        }
      },
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
