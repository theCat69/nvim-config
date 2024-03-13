local M = {}

local format_key_binding = "<A-l>"
local format_vim_input = "mugg=Gxu"

local function active_client_format_supported()
  for _, client in ipairs(vim.lsp.get_clients({ bufnr = 0 })) do
    if client and client.supports_method("textDocument/formatting") then
      return true
    end
  end
  return false
end

local activated = true

function M.deactivate()
  activated = false
end

function M.activate()
  activated = true
end

function M.activate_switch()
  if activated then
    M.deactivate()
  else
    M.activate()
  end
end

function M.format_lsp()
  if activated then
    vim.lsp.buf.format({ sync = true })
  end
end

function M.format_vim()
  if activated then
    vim.api.nvim_input(format_vim_input)
  end
end

function M.format_lsp_with_fallback()
  if active_client_format_supported() then
    M.format_lsp()
  else
    M.format_vim()
  end
end

function M.format_activated_switch_set_key()
  vim.keymap.set("n", "<A-L>", M.activate_switch)
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
    pattern = { "*.rs", "*.ts", "*.tsx", "*.html", "*.css", "*.py", "*.xml", "*.json", "*.yml", "*.js", "*.lua", "*.sol", "*.java" }, -- supported format on save
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
