local function theme_colorscheme()
  local red = "#9D0006"
  local orange = "#AF3A03"
  local green = "#79740E"
  local blue = "#076678"
  local purple = "#8F3F71"

  if require("plugins.ui.theme-metadata").is_dark_theme() then
    red = "#FB4934"
    orange = "#FE8019"
    green = "#B8BB26"
    blue = "#83A598"
    purple = "#D3869B"
  end

  vim.cmd("highlight NotifyERRORTitle  guifg=" .. red)
  vim.cmd("highlight NotifyWARNTitle guifg=" .. orange)
  vim.cmd("highlight NotifyINFOTitle guifg=" .. green)
  vim.cmd("highlight NotifyDEBUGTitle  guifg=" .. blue)
  vim.cmd("highlight NotifyTRACETitle  guifg=" .. purple)
  vim.cmd("highlight NotifyERRORIcon guifg=" .. red)
  vim.cmd("highlight NotifyWARNIcon guifg=" .. orange)
  vim.cmd("highlight NotifyINFOIcon guifg=" .. green)
  vim.cmd("highlight NotifyDEBUGIcon guifg=" .. blue)
  vim.cmd("highlight NotifyTRACEIcon guifg=" .. purple)
end

local function config()
  ---@diagnostic disable-next-line: missing-fields
  require("notify").setup({
    background_colour = "#D3D3D3",
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
