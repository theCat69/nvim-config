local function config()
  require('refactoring').setup({
    show_success_message = true
  })

  -- load refactoring Telescope extension
  require("telescope").load_extension("refactoring")

  -- remap to open the Telescope refactoring menu in visual mode
  vim.api.nvim_set_keymap(
    "v",
    "<leader>rr",
    "<Esc><cmd>lua require('telescope').extensions.refactoring.refactors()<CR>",
    { noremap = true }
  )
end

---@type LazyPluginSpec[]
return {
  {
    "ThePrimeagen/refactoring.nvim",
    dependencies = {
      { "nvim-lua/plenary.nvim" },
      { "nvim-treesitter/nvim-treesitter" }
    },
    config = config,
    lazy = true
  }
}
