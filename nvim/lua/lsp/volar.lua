local base = require("lsp._base")
local util = require("lspconfig/util")

local global_modules = util.path.join(vim.env.FNM_DIR, "aliases", "default", "lib", "node_modules")
local function get_typescript_server_path(root_dir)
  -- use typescript install under the project's node_modules
  -- if not found, use global installation
  local global_ts = util.path.join(global_modules, "typescript", "lib")
  local found_ts = ""
  local function check_dir(path)
    found_ts =  util.path.join(path, "node_modules", "typescript", "lib")
    if util.path.exists(found_ts) then
      return path
    end
  end
  if util.search_ancestors(root_dir, check_dir) then
    return found_ts
  else
    return global_ts
  end
end

require("lspconfig").volar.setup({
  filetypes = { "typescript", "javascript", "vue" },
  init_options = {
    vue = { hybridMode = false },
  },
  on_new_config = function(new_config, new_root_dir)
    new_config.init_options.typescript.tsdk = get_typescript_server_path(new_root_dir)
  end,
  on_attach = base.on_attach_lsp,
  capabilities = base.capabilities,
})
