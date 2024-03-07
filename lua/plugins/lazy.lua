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

---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

local lazy_utils = require("plugins.lazy-utils");

lazy_utils.register_plugin(require("plugins.ui.theme"))
lazy_utils.register_plugin(require("plugins.ui.lualine"))
lazy_utils.register_plugin(require("plugins.ui.nvim-tree"))
lazy_utils.register_plugin(require("plugins.jumping.telescope"))
lazy_utils.register_plugin(require("plugins.ui.dropbar"))
lazy_utils.register_plugin(require("plugins.ui.noice"))
lazy_utils.register_plugin(require("plugins.jumping.arrow"))
lazy_utils.register_plugin(require("plugins.git.git"))
lazy_utils.register_plugin(require("plugins.no-lsp.treesitter"))
lazy_utils.register_plugin(require("plugins.no-lsp.refactoring"))
lazy_utils.register_plugin(require("plugins.no-lsp.cmp"))
lazy_utils.register_plugin(require("plugins.no-lsp.misc"))
-- lazy_utils.register_plugin(require("plugins.lsp.action-preview"))
lazy_utils.register_plugin(require("plugins.lsp.lsp"))
lazy_utils.register_plugin(require("plugins.lsp.sql"))
lazy_utils.register_plugin(require("plugins.ai.gen"))

require('lazy').setup(lazy_utils.get_plugins())
