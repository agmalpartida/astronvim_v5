-- This file simply bootstraps the installation of Lazy.nvim and then calls other files for execution
-- This file doesn't necessarily need to be touched, BE CAUTIOUS editing this file and proceed at your own risk.
local lazypath = vim.env.LAZY or vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not (vim.env.LAZY or (vim.uv or vim.loop).fs_stat(lazypath)) then
  -- stylua: ignore
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end
vim.opt.rtp:prepend(lazypath)

-- validate that lazy is available
if not pcall(require, "lazy") then
  -- stylua: ignore
  vim.api.nvim_echo({ { ("Unable to load lazy from: %s\n"):format(lazypath), "ErrorMsg" }, { "Press any key to exit...", "MoreMsg" } }, true, {})
  vim.fn.getchar()
  vim.cmd.quit()
end

require "lazy_setup"
require "polish"


-- local buffer_closer = require("buffer-closer.modules.buffer")
--
-- local function is_custom_excluded(bufnr)
--   local name = vim.api.nvim_buf_get_name(bufnr)
--   -- Patrón que busca ".check.md" en cualquier parte del nombre (ajustar si quieres desde fin '$')
--   if string.match(name, "%.check.md$") then
--     return true
--   end
--   return false
-- end
--
-- for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
--   local excluded_builtin = buffer_closer.is_excluded(bufnr, {
--     filenames = {}, filetypes = {}, buftypes = {}
--   })
--   local excluded_custom = is_custom_excluded(bufnr)
--   print("Buffer:", vim.api.nvim_buf_get_name(bufnr), "Builtin excluded:", excluded_builtin, "Custom excluded:", excluded_custom)
-- end
