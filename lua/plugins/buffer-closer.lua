
local function is_custom_excluded(bufnr)
  local name = vim.api.nvim_buf_get_name(bufnr)
  return string.match(name, "%.check.md$")
end

require("buffer-closer").setup({
  min_remaining_buffers = 3,
  retirement_minutes = 1,
  excluded = {
    filenames = {},
    filetypes = {},
    buftypes = {},
  },
  ignore_working_windows = true,

  on_retire = function()
    for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
      if not is_custom_excluded(bufnr) then
        -- lógica para cerrar buffers aquí si es posible según el plugin
      end
    end
  end,
})
