local packer = require("packer")

---- convenience layer
packer.use "neovim/nvim-lspconfig"

---- autocompletion
packer.use "hrsh7th/cmp-buffer"
packer.use "hrsh7th/cmp-cmdline"
packer.use "hrsh7th/cmp-nvim-lsp-signature-help"
packer.use "hrsh7th/cmp-nvim-lsp"
packer.use "hrsh7th/cmp-path"
packer.use "hrsh7th/nvim-cmp"
packer.use "hrsh7th/vim-vsnip"

packer.use "ray-x/lsp_signature.nvim"

local util = require("lspconfig/util")

local function get_python_path()
  if vim.env.VIRTUAL_ENV then
    return util.path.join(vim.env.VIRTUAL_ENV, "bin", "python")
  end

  return vim.fn.exepath("python")
end

local hide_info = true
local toggle_hide_info = function()
  local buf = vim.api.nvim_create_buf(0, 1)
  vim.api.nvim_buf_set_option(buf, "bufhidden", "wipe")
  vim.api.nvim_buf_set_option(buf, "buftype", "nofile")
  vim.api.nvim_buf_set_option(buf, "swapfile", false)
  vim.api.nvim_buf_set_option(buf, "buflisted", false)
  vim.api.nvim_buf_set_name(buf, "Wandu")

  vim.api.nvim_command("split")
  vim.api.nvim_set_current_buf(buf)

  hide_info = not hide_info
  local di = vim.diagnostic.get(0)
  local lines = {}
  for line in string.gmatch(vim.inspect(di), "[^\r\n]+") do
    table.insert(lines, line)
  end
  vim.api.nvim_buf_set_lines(buf, 0, 0, false, {tostring(hide_info)})
  vim.api.nvim_buf_set_lines(buf, 1, -1, false, lines)

  -- print(hide_info)
  -- print(vim.inspect(vim.diagnostic.get(0)))
  -- vim.diagnostic.show(nil, 0)
  -- TODO: refresh diagnostics
end

vim.keymap.set("n", "+", toggle_hide_info, { noremap = true })

local function filter_unused(arr, func)
  -- Filter in place
  -- https://stackoverflow.com/questions/49709998/how-to-filter-a-lua-array-inplace
  local new_index = 1
  local size_orig = #arr
  for old_index, v in ipairs(arr) do
      if func(v, old_index) then
          arr[new_index] = v
          new_index = new_index + 1
      end
  end
  for i = new_index, size_orig do arr[i] = nil end
end

local function is_unused_message(diagnostic)
  -- Allow kwargs to be unused, sometimes you want many functions to take the
  -- same arguments but you don't use all the arguments in all the functions,
  -- so kwargs is used to suck up all the extras
  if not hide_info then
    return true
  end
  if diagnostic.message == '"kwargs" is not accessed' then
  	return false
  end
  --
  -- Allow variables starting with an underscore
  if string.match(diagnostic.message, '"_.+" is not accessed') then
  	return false
  end


  -- For all messages "is not accessed"
  if string.match(diagnostic.message, '".+" is not accessed') then
      return false
  end

  return true
end

local function custom_handler(a, result, c, config)
  filter_unused(result.diagnostics, is_unused_message)
  return vim.lsp.diagnostic.on_publish_diagnostics(a, result, c, config)
end


-- Set up lspconfig.
local capabilities = require("cmp_nvim_lsp").default_capabilities()
capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true
}

local on_attach_lsp = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
  -- vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
  vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
  -- vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set("n", "<leader>s", vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set("n", "<space>wl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, bufopts)
  vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, bufopts)
  vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
  vim.keymap.set("n", "<space>f", function() vim.lsp.buf.format { async = true } end, bufopts)

  if client.name == "pyright" then
    -- vim.keymap.set('n', '<Leader>o', '<CMD>PyrightOrganizeImports<CR>')
    vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
        custom_handler, {})
  end
end

require("lspconfig").pyright.setup({
  single_file_support = true,
  settings = {
    analysis = {
      diagnosticMode = "openFilesOnly"
    }
  },
  on_attach = on_attach_lsp,
  capabilities = capabilities,
  before_init = function(_, config)
    config.settings.python.pythonPath = get_python_path()
  end,
})

require("lspconfig").lua_ls.setup({
  single_file_support = true,
  on_init = function(client)
    local path = client.workspace_folders[1].name
    if not vim.loop.fs_stat(path..'/.luarc.json') and not vim.loop.fs_stat(path..'/.luarc.jsonc') then
      client.config.settings = vim.tbl_deep_extend('force', client.config.settings.Lua, {
        runtime = {
          -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
          version = 'LuaJIT'
        },
        -- Make the server aware of Neovim runtime files
        workspace = {
          library = { vim.env.VIMRUNTIME }
          -- or pull in all of 'runtimepath'. NOTE: this is a lot slower
          -- library = vim.api.nvim_get_runtime_file("", true)
        }
      })

      client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
    end
    return true
  end,
})

require("lsp_signature").setup({})

vim.diagnostic.config({
  virtual_text = true,
  signs = false,
  update_in_insert = true,
})

local cmp = require("cmp")
-- local cmp_autopairs = require('nvim-autopairs.completion.cmp')
cmp.setup({
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
      -- require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
      -- require("snippy").expand_snippet(args.body) -- For `snippy` users.
      -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
    end,
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.abort(),
    ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    ["<Tab>"] = cmp.mapping(
      function(fallback)
        if cmp.visible()
          then cmp.confirm({ select = true })
          else fallback()
          end
      end
    ),
  }),
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    -- { name = "vsnip" }, -- For vsnip users.
    -- { name = "luasnip" }, -- For luasnip users.
    -- { name = "ultisnips" }, -- For ultisnips users.
    -- { name = "snippy" }, -- For snippy users.
  },
  -- { { name = "nvim_lsp_signature_help" } },
  { { name = "buffer" }, }
  ),
  experimental = { ghost_text = {} }
})

-- Set configuration for specific filetype.
cmp.setup.filetype("gitcommit", {
  sources = cmp.config.sources({
    { name = "cmp_git" }, -- You can specify the `cmp_git` source if you were installed it.
  }, {
    { name = "buffer" },
  })
})

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ "/", "?" }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = "buffer" }
  }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(":", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = "path" }
  }, {
    { name = "cmdline" }
  })
})
--
------ diagnostics list
packer.use("folke/trouble.nvim")
require("trouble").setup({ mode = "document_diagnostics", use_diagnostic_sign = true })
vim.api.nvim_set_keymap("n", "<C-Q>", ":TroubleToggle<CR>", { noremap = true })
