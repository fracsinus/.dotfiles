local log = require("vertical-tabline.log")
local tabs = require("vertical-tabline.tabs")
local ui = require("vertical-tabline.ui")

local M = {}

local defaults = {
  width = 20,
  side = "left",
  toggle_key = "<leader>t",
  debug = false,
}

local state = {
  buf = nil,
  config = {},
}

---Gathers tab data, formats lines, and renders into the tabline buffer.
local function refresh()
  if not state.buf or not vim.api.nvim_buf_is_valid(state.buf) then
    return
  end
  local tab_list = tabs.get_list()
  local lines = {}
  for _, tab in ipairs(tab_list) do
    table.insert(lines, tab.name)
  end
  ui.render(state.buf, lines)
end

---Opens the tabline in the current tab. Creates the buffer if needed.
---@param enter boolean whether to enter the tabline window
local function open(enter)
  if not state.buf or not vim.api.nvim_buf_is_valid(state.buf) then
    state.buf = ui.create_buf(function()
      state.buf = nil
    end)
  end
  refresh()
  ui.open_win(state.buf, {
    width = state.config.width,
    side = state.config.side,
    enter = enter,
  })
end

---TabEnter handler: ensures the tabline is visible in the new tab.
local function on_tab_enter()
  if not state.buf then
    return
  end
  local current_tab = vim.api.nvim_get_current_tabpage()
  if not ui.is_visible_in_tab(state.buf, current_tab) then
    log.debug("Opening tabline in tab " .. current_tab)
    open(false)
  end
end

---@param opts? table
function M.setup(opts)
  state.config = vim.tbl_deep_extend("force", defaults, opts or {})
  log.set_debug(state.config.debug)

  vim.keymap.set("n", state.config.toggle_key, M.toggle, { desc = "Toggle vertical tabline" })

  vim.api.nvim_create_autocmd({ "TabNew", "TabClosed" }, {
    callback = refresh,
  })
  vim.api.nvim_create_autocmd({ "TabEnter" }, {
    callback = vim.schedule_wrap(on_tab_enter),
  })
end

function M.toggle()
  if not state.buf then
    open(true)
  else
    vim.api.nvim_buf_delete(state.buf, {})
  end
end

---Renames the current tab. Prompts for input if no name given.
---@param name? string
function M.rename(name)
  local tab_id = vim.api.nvim_get_current_tabpage()
  if name then
    tabs.set_name(tab_id, name)
    refresh()
  else
    vim.ui.input({ prompt = "Tab name: " }, function(input)
      if input and input ~= "" then
        tabs.set_name(tab_id, input)
        refresh()
      end
    end)
  end
end

---Clears the custom name of the current tab.
function M.clear_name()
  tabs.clear_name(vim.api.nvim_get_current_tabpage())
  refresh()
end

return M
