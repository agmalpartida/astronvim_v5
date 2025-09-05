
local function close_retired_buffers(custom_excluded, retirement_minutes, min_remaining_buffers)
  local bufs = vim.api.nvim_list_bufs()
  local current_time = os.time()
  local to_close = {}

  for _, bufnr in ipairs(bufs) do
    local name = vim.api.nvim_buf_get_name(bufnr)
    if name ~= "" and not custom_excluded(bufnr) then
      local lastused = vim.fn.getbufinfo(bufnr)[1].lastused
      -- lastused es tiempo en segundos de última vez usado
      local idle_time = current_time - lastused
      if idle_time > retirement_minutes * 60 then
        table.insert(to_close, bufnr)
      end
    end
  end

  -- Cierra buffers respetando mínimo abierto
  local open_count = #bufs
  for _, bufnr in ipairs(to_close) do
    if open_count > min_remaining_buffers then
      vim.api.nvim_buf_delete(bufnr, { force = true })
      open_count = open_count - 1
    end
  end
end

local function is_custom_excluded(bufnr)
  local name = vim.api.nvim_buf_get_name(bufnr)
  return string.match(name, "%.check.md$")
end

-- Timer que ejecuta cierre cada minuto (60000 ms)
vim.loop.new_timer():start(0, 60000, vim.schedule_wrap(function()
  close_retired_buffers(is_custom_excluded, 1, 3)
end))
