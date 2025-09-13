return {
  "sontungexpt/buffer-closer",
  event = "VeryLazy",
  config = function()
    local settings = {
      excluded_filetypes = { "lazy", "NvimTree", "mason", "neo-tree" },
      excluded_buftypes = { "terminal", "nofile", "quickfix", "prompt", "help" },
      retirement_minutes = 1,
      min_remaining_buffers = 3,
    }

    local function is_excluded(bufnr)
      local filetype = vim.api.nvim_get_option_value("filetype", { buf = bufnr })
      local buftype = vim.api.nvim_get_option_value("buftype", { buf = bufnr })
      local name = vim.api.nvim_buf_get_name(bufnr)
      for _, ft in ipairs(settings.excluded_filetypes) do
        if filetype == ft then return true end
      end
      for _, bt in ipairs(settings.excluded_buftypes) do
        if buftype == bt then return true end
      end
      if string.match(name, "%.check.md$") then
        return true
      end
      return false
    end

    local function close_retired_buffers()
      local bufs = vim.api.nvim_list_bufs()
      local current_time = os.time()
      local to_close = {}

      -- Contar sólo buffers no excluidos y con nombre válido
      local non_excluded_count = 0
      for _, bufnr in ipairs(bufs) do
        local name = vim.api.nvim_buf_get_name(bufnr)
        if name ~= "" and not is_excluded(bufnr) then
          non_excluded_count = non_excluded_count + 1
        end
      end

      -- Buscar buffers candidatos a cerrar
      for _, bufnr in ipairs(bufs) do
        local name = vim.api.nvim_buf_get_name(bufnr)
        if name ~= "" and not is_excluded(bufnr) then
          local bufinfo = vim.fn.getbufinfo(bufnr)[1]
          if bufinfo and bufinfo.lastused then
            local idle_time = current_time - bufinfo.lastused
            if idle_time > settings.retirement_minutes * 60 then
              table.insert(to_close, bufnr)
            end
          end
        end
      end

      -- Solo cerrar si quedan más de min_remaining_buffers NO EXCLUIDOS
      for _, bufnr in ipairs(to_close) do
        if non_excluded_count > settings.min_remaining_buffers then
          vim.api.nvim_buf_delete(bufnr, { force = true })
          non_excluded_count = non_excluded_count - 1
        end
      end
    end

    vim.loop.new_timer():start(0, 60000, vim.schedule_wrap(close_retired_buffers))
  end,
}
