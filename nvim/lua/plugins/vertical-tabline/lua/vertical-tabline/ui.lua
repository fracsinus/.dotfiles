local log = require("vertical-tabline.log")

local M = {}

local FILETYPE = "VerticalTabline"

---Creates a new scratch buffer configured for the tabline.
---@param on_delete fun() callback invoked when the buffer is deleted/wiped
---@return number bufnr
function M.create_buf(on_delete)
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_set_option_value("filetype", FILETYPE, { buf = buf })
  vim.api.nvim_set_option_value("buftype", "nofile", { buf = buf })
  vim.api.nvim_set_option_value("bufhidden", "wipe", { buf = buf })
  vim.api.nvim_set_option_value("buflisted", false, { buf = buf })
  vim.api.nvim_create_autocmd({ "BufDelete", "BufWipeout" }, {
    buffer = buf,
    callback = function()
      on_delete()
    end,
  })
  log.debug("Buffer created: " .. buf)
  return buf
end

---Renders lines into the tabline buffer.
---@param buf number
---@param lines string[]
function M.render(buf, lines)
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
end

---Opens the tabline buffer in a vertical split window.
---@param buf number
---@param opts { width: number, side: string, enter: boolean }
---@return number winid
function M.open_win(buf, opts)
  local win = vim.api.nvim_open_win(buf, opts.enter, {
    split = opts.side,
    vertical = true,
    width = opts.width,
  })
  vim.api.nvim_set_option_value("number", false, { win = win })
  vim.api.nvim_set_option_value("relativenumber", false, { win = win })
  vim.api.nvim_set_option_value("winfixwidth", true, { win = win })
  log.debug("Window opened: " .. win)
  return win
end

---Checks if a buffer is currently displayed in any window of a given tab.
---@param buf number
---@param tab_id number
---@return boolean
function M.is_visible_in_tab(buf, tab_id)
  for _, win in ipairs(vim.api.nvim_tabpage_list_wins(tab_id)) do
    if vim.api.nvim_win_get_buf(win) == buf then
      return true
    end
  end
  return false
end

return M
