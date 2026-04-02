local log = require("vertical-tabline.log")

local M = {}

local TABNAME_VAR = "vertical_tabline_tabname"

---Resolves display name for a single tab.
---Priority: custom name (tab var) > basename of active buffer > "[No Name]"
---@param tab_id number
---@return string
function M.resolve_name(tab_id)
  local ok, tabname = pcall(vim.api.nvim_tabpage_get_var, tab_id, TABNAME_VAR)
  if ok then
    return tabname
  end
  local win = vim.api.nvim_tabpage_get_win(tab_id)
  local bufnr = vim.api.nvim_win_get_buf(win)
  local bufname = vim.api.nvim_buf_get_name(bufnr)
  if bufname == nil or bufname == "" then
    return "[No Name]"
  end
  return vim.fs.basename(bufname)
end

---Returns an ordered list of tab descriptors.
---@return { id: number, name: string, is_current: boolean }[]
function M.get_list()
  local current = vim.api.nvim_get_current_tabpage()
  local result = {}
  for _, tab_id in ipairs(vim.api.nvim_list_tabpages()) do
    table.insert(result, {
      id = tab_id,
      name = M.resolve_name(tab_id),
      is_current = (tab_id == current),
    })
  end
  return result
end

---Sets a custom name for a tab.
---@param tab_id number
---@param name string
function M.set_name(tab_id, name)
  vim.api.nvim_tabpage_set_var(tab_id, TABNAME_VAR, name)
  log.debug("Set tab name: " .. name .. " for tab " .. tab_id)
end

---Clears the custom name for a tab, reverting to auto-resolve.
---@param tab_id number
function M.clear_name(tab_id)
  pcall(vim.api.nvim_tabpage_del_var, tab_id, TABNAME_VAR)
  log.debug("Cleared tab name for tab " .. tab_id)
end

---Given a 1-based line number, returns the corresponding tab_id, or nil.
---@param line number
---@return number|nil
function M.line_to_tab_id(line)
  local tabpages = vim.api.nvim_list_tabpages()
  return tabpages[line]
end

return M
