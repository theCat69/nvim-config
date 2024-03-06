local M = {}

local format_key_binding = "<A-l>"
local format_vim_input = "mugg=Gxu"

local function active_client_format_supported()
  for _, client in ipairs(vim.lsp.get_active_clients({ bufnr = 0 })) do
    if client and client.supports_method("textDocument/formatting") then
      return true
    end
    return false
  end
end

function M.format_lsp()
  vim.lsp.buf.format({ sync = true })
end

function M.format_vim()
  vim.api.nvim_input(format_vim_input)
end

function M.format_lsp_with_fallback()
  if active_client_format_supported() then
    M.format_lsp()
  else
    M.format_vim()
  end
end

function M.format_vim_set_key()
  vim.keymap.set("n", format_key_binding, M.format_vim)
end

function M.format_lsp_set_key()
  vim.keymap.set("n", format_key_binding, M.format_lsp_with_fallback)
end

function M.format_lsp_autocmd()
  -- format on save using lsp
  vim.api.nvim_create_autocmd('BufWritePre', {
    group = vim.api.nvim_create_augroup('onSaveEvent', { clear = true }),
    pattern = { "*.rs", "*.ts", "*.tsx", "*.html", "*.css", "*.py", "*.xml", "*.json", "*.yml", "*.js", "*.lua", "*.sol" }, -- supported format on save
    callback = M.format_lsp_with_fallback,
  })
end

function M.format_vim_autocmd()
  -- format on save using vim (possibly treesitter)
  vim.api.nvim_create_autocmd('BufWritePre', {
    group = vim.api.nvim_create_augroup('onSaveEvent', { clear = true }),
    pattern = { "*.groovy", ".gitconfig", "nginx.conf", "https_server.conf" }, -- supported format on save
    callback = M.format_vim,
  })
end

return M
