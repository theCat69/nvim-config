-- filtypes to load all the lsp plugins
local ft = {
  "lua", "sql", "rust", "xml", "json", "solidity", "typescript", "javascript", "html", "css",
  "python", "kotlin", "zig", "docker", "toml", "yaml", "c", "bash", "go", "typescriptreact", "sh"
}

-- cmd that trigger the load of all lsp plugins
local cmd = { "MasonUpdate", "MasonUpdateAll" }

-- Enable the following language servers
-- Feel free to add/remove any LSPs that you want here.
-- servers automatically installed by mason
-- Those will inherit the default capabilities and on attach if not specificy otherwise
local servers = { 'clangd', 'rust_analyzer', 'pyright', 'lua_ls', 'yamlls', 'lemminx', 'emmet_ls',
  'kotlin_language_server', 'html', 'cssls', 'bashls', 'jsonls', 'tailwindcss', 'zls', 'dockerls', 'solidity_ls',
  'taplo', 'gopls', 'angularls', 'ts_ls' }

local function config()
  require('neodev').setup({
    library = { plugins = { "nvim-dap-ui" }, types = true },
  })

  require('mason-lspconfig').setup {
    ensure_installed = servers,
    automatic_installation = true,
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
    config = config,
    ft = ft,
    cmd = cmd,
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
  {
    ft = ft,
    "folke/neodev.nvim",
    dependencies = {
      'MunifTanjim/nui.nvim',
      require("plugins.lsp.dap")
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
