local opts = { noremap = true, silent = true }
local map = vim.api.nvim_set_keymap
map('n', '<leader>rd', "<Cmd>lua require('dap').continue()<CR>", opts)
map('n', '<leader>qd', "<Cmd>lua require('dap').terminate()<CR>", opts)
map('n', '<leader>tb', "<Cmd>lua require('dap').toggle_breakpoint()<CR>", opts)
map('n', '<leader>so', "<Cmd>lua require('dap').step_over()<CR>", opts)
map('n', '<leader>si', "<Cmd>lua require('dap').step_into()<CR>", opts)
