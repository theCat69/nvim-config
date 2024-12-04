-- Set lualine as statusline
-- See `:help lualine.txt`

local function show_macro_recording()
  local recording_register = vim.fn.reg_recording()
  if recording_register == "" then
    return ""
  else
    return "Recording @" .. recording_register
  end
end

local function macro_recording_autocmd()
  vim.api.nvim_create_autocmd("RecordingEnter", {
    callback = function()
      require("lualine").refresh({
        place = { "statusline" },
      })
    end,
  })

  vim.api.nvim_create_autocmd("RecordingLeave", {
    callback = function()
      -- This is going to seem really weird!
      -- Instead of just calling refresh we need to wait a moment because of the nature of
      -- `vim.fn.reg_recording`. If we tell lualine to refresh right now it actually will
      -- still show a recording occuring because `vim.fn.reg_recording` hasn't emptied yet.
      -- So what we need to do is wait a tiny amount of time (in this instance 50 ms) to
      -- ensure `vim.fn.reg_recording` is purged before asking lualine to refresh.
      local timer = vim.loop.new_timer()
      if timer ~= nil then
        timer:start(
          50,
          0,
          vim.schedule_wrap(function()
            require("lualine").refresh({
              place = { "statusline" },
            })
          end)
        )
      end
    end,
  })
end

local function config()
  require('lualine').setup {
    options = {
      icons_enabled = false,
      theme = 'gruvbox',
      component_separators = '|',
      section_separators = '',
    },
    sections = {
      lualine_b = {
        {
          "macro-recording",
          fmt = show_macro_recording,
        },
      },
    }
  }

  macro_recording_autocmd()
end


---@type LazyPluginSpec
return {
  'nvim-lualine/lualine.nvim',
  config = config,
}
