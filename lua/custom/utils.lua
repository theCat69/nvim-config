local function replace_with_translate()
  local s_buf, s_col, s_row = unpack(vim.fn.getpos("v"))
  local _, e_col, e_row = unpack(vim.fn.getpos("."))
  local n_lines = math.abs(e_col - s_col) + 1
  local lines = vim.api.nvim_buf_get_lines(0, s_col - 1, e_col, false)
  lines[1] = string.sub(lines[1], s_row, -1)

  if n_lines == 1 then
    lines[n_lines] = string.sub(lines[n_lines], 1, e_row - s_row + 1)
  else
    lines[n_lines] = string.sub(lines[n_lines], 1, e_row)
  end

  local line = lines[1]
  vim.print(line)
  local string_to_replace_with = string.format("t('@@%s')", line);
  print(string_to_replace_with)
  -- Delete selected visual selection
  -- vim.api.nvim_buf_set_text(s_buf, s_row, s_col, e_row, e_col, {})
  vim.api.nvim_feedkeys('d', 'v', true);
  -- Exit visual mode
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<esc>', true, false, true), 'x', false)
  -- Place line.
  vim.api.nvim_put({ string_to_replace_with }, "", false, false)
  -- vim.api.nvim_buf_set_text(s_buf, s_row, s_col, e_row, e_col, { string_to_replace_with })
  -- vim.api.nvim_buf_set_text(s_buf, s_row, s_col, s_row, s_col, { string_to_replace_with })
end

vim.keymap.set('v', '<leader>tt', replace_with_translate, { noremap = true, silent = true })
