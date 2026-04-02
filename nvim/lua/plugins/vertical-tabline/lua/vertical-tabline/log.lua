local M = {}

local enabled = false
local PREFIX = "[vertical-tabline]"

---@param flag boolean
function M.set_debug(flag)
  enabled = flag
end

---@param msg string
function M.debug(msg)
  if enabled then
    vim.notify(PREFIX .. " " .. msg, vim.log.levels.DEBUG)
  end
end

---@param msg string
function M.info(msg)
  vim.notify(PREFIX .. " " .. msg, vim.log.levels.INFO)
end

---@param msg string
function M.warn(msg)
  vim.notify(PREFIX .. " " .. msg, vim.log.levels.WARN)
end

---@param msg string
function M.error(msg)
  vim.notify(PREFIX .. " " .. msg, vim.log.levels.ERROR)
end

return M
