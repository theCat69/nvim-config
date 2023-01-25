-- format on save using lsp
vim.api.nvim_create_autocmd('BufWritePre', {
  group = vim.api.nvim_create_augroup('onSaveEvent', { clear = true }),
  pattern = { "*.rs", "*.ts", "*.tsx", "*.html", "*.css", "*.py", "*.xml", "*.json", "*.yml", "*.js", "*.lua" }, -- supported format on save
  callback = function()
    vim.lsp.buf.format({ sync = true })
  end,
})

-- java autocommands
local insert_java_packages = function()
  local filename = vim.fn.expand("%:t:r")
  local filepath = vim.fn.expand("%")
  filepath = filepath:gsub("[/|\\\\]" .. filename .. ".java", "")
  filepath = filepath:gsub(".*/java/", "")
  filepath = filepath:gsub("[/|\\\\]", ".")
  vim.api.nvim_buf_set_lines(0, 0, 0, false, {
    "package " .. filepath .. ";",
    "",
    "public class " .. filename .. " {",
    "",
    "}"
  })
  vim.api.nvim_win_set_cursor(0, { 4, 2 })
end


vim.api.nvim_create_autocmd('BufNewFile', {
  group = vim.api.nvim_create_augroup('onCreateFileEvent', { clear = true }),
  pattern = { "*.java" },
  callback = function()
    insert_java_packages()
  end,
})
