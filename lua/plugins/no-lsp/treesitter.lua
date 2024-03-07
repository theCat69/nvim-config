-- [[ Configure Treesitter ]]
-- See `:help nvim-treesitter`
local function config()
  require('nvim-treesitter.configs').setup {
    -- Add languages to be installed here that you want installed for treesitter
    ensure_installed = { 'c', 'cpp', 'go', 'lua', 'python', 'rust', 'typescript', 'java', 'yaml', 'kotlin', 'tsx', 'bash', 'groovy', 'zig', 'solidity' },
    sync_install = false,
    ignore_install = {},
    modules = {},
    auto_install = true,
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
    },
    indent = { enable = true },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "gnn", -- set to `false` to disable one of the mappings
        node_incremental = "grn",
        scope_incremental = "grc",
        node_decremental = "grm",
      },
    },
    textobjects = {
      select = {
        enable = true,
        lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
        keymaps = {
          -- You can use the capture groups defined in textobjects.scm
          ['gpo'] = '@parameter.outer',
          ['gpi'] = '@parameter.inner',
          ['gfo'] = '@function.outer',
          ['gfi'] = '@function.inner',
          ['gCo'] = '@class.outer',
          ['gCi'] = '@class.inner',
        },
      },
      move = {
        enable = true,
        set_jumps = true, -- whether to set jumps in the jumplist
        goto_next_start = {
          ['gnso'] = '@parameter.outer',
          ['gnsi'] = '@parameter.inner',
          ['})'] = '@function.outer',
          ['}}'] = '@class.outer',
        },
        goto_next_end = {
          ['gneo'] = '@parameter.outer',
          ['gnei'] = '@parameter.inner',
          ['}('] = '@function.outer',
          ['}{'] = '@class.outer',
        },
        goto_previous_start = {
          ['gpso'] = '@parameter.outer',
          ['gpsi'] = '@parameter.inner',
          ['{)'] = '@function.outer',
          ['{}'] = '@class.outer',
        },
        goto_previous_end = {
          ['gpeo'] = '@parameter.outer',
          ['gpei'] = '@parameter.inner',
          ['{('] = '@function.outer',
          ['{{'] = '@class.outer',
        },
      },
      swap = {
        enable = true,
        swap_next = {
          ['<leader>a'] = '@parameter.inner',
        },
        swap_previous = {
          ['<leader>A'] = '@parameter.inner',
        },
      },
    },
  }
end

---@type LazyPluginSpec
return {
  'nvim-treesitter/nvim-treesitter',
  build = function()
    pcall(require('nvim-treesitter.install').update { with_sync = true })
  end,
  dependencies = {
    'nvim-treesitter/nvim-treesitter-textobjects',
  },
  config = config
}
