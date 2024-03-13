local colors = require("metadata.ui").get_colors()

local function theme_colorscheme()
  vim.cmd("highlight NotifyERRORTitle  guifg=" .. colors.red)
  vim.cmd("highlight NotifyWARNTitle guifg=" .. colors.orange)
  vim.cmd("highlight NotifyINFOTitle guifg=" .. colors.green)
  vim.cmd("highlight NotifyDEBUGTitle  guifg=" .. colors.blue)
  vim.cmd("highlight NotifyTRACETitle  guifg=" .. colors.purple)
  vim.cmd("highlight NotifyERRORIcon guifg=" .. colors.red)
  vim.cmd("highlight NotifyWARNIcon guifg=" .. colors.orange)
  vim.cmd("highlight NotifyINFOIcon guifg=" .. colors.green)
  vim.cmd("highlight NotifyDEBUGIcon guifg=" .. colors.blue)
  vim.cmd("highlight NotifyTRACEIcon guifg=" .. colors.purple)
end

local function config()
  ---@diagnostic disable-next-line: missing-fields
  require("notify").setup({
    background_colour = colors.background_secondary,
    stages = "fade",
    timeout = 1000,
  })
  -- for notify nvim
  theme_colorscheme()

  require("noice").setup({
    lsp = {
      -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
      override = {
        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
        ["vim.lsp.util.stylize_markdown"] = true,
        ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
      },
    },
    -- you can enable a preset for easier configuration
    presets = {
      bottom_search = true,         -- use a classic bottom cmdline for search
      command_palette = true,       -- position the cmdline and popupmenu together
      long_message_to_split = true, -- long messages will be sent to a split
      inc_rename = false,           -- enables an input dialog for inc-rename.nvim
      lsp_doc_border = false,       -- add a border to hover docs and signature help
    },
    views = {
      cmdline_popup = {
        backend = "popup",
        relative = "editor",
        focusable = false,
        enter = false,
        zindex = 200,
        position = {
          row = "70%",
          col = "50%",
        },
        size = {
          min_width = 60,
          width = "auto",
          height = "auto",
        },
        border = {
          style = "rounded",
          padding = { 0, 1 },
        },
        win_options = {
          winhighlight = {
            Normal = "NoiceCmdlinePopup",
            FloatTitle = "NoiceCmdlinePopupTitle",
            FloatBorder = "NoiceCmdlinePopupBorder",
            IncSearch = "",
            CurSearch = "",
            Search = "",
          },
          winbar = "",
          foldenable = false,
          cursorline = false,
        },
      },
    }
  })
end

---@type LazyPluginSpec
return {
  "folke/noice.nvim",
  config = config,
  event = "VeryLazy",
  dependencies = {
    -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
    "MunifTanjim/nui.nvim",
    -- OPTIONAL:
    --   `nvim-notify` is only needed, if you want to use the notification view.
    --   If not available, we use `mini` as the fallback
    "rcarriga/nvim-notify",
  }
}
