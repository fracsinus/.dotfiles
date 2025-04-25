local M = {}

M.capabilities = require("cmp_nvim_lsp").default_capabilities()

-- M.capabilities.textDocument.foldingRange = {
--     dynamicRegistration = false,
--     lineFoldingOnly = true
-- }

M.on_attach_lsp = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set("n", "<leader>gD", "<cmd>tab sb | lua vim.lsp.buf.declaration()<CR>", bufopts)
  vim.keymap.set(
    "n",
    "<leader>gd",
    function()
      local position = vim.lsp.util.make_position_params(0, 'utf-8')
      vim.lsp.buf_request_all(
        0,
        "textDocument/definition",
        position,
        function (response)
          for _, client_response in pairs(response) do
            local result = client_response.result
            if not vim.islist(result) then
              return
            end
            for _, location in pairs(result) do
              local uri = location.uri or location.targetUri
              local fname = vim.uri_to_fname(uri)
              local range = location.range
              local current_buf_name = vim.api.nvim_buf_get_name(0)
              if fname == current_buf_name then
                vim.cmd("tabedit " .. vim.fn.fnameescape(fname))
              else
                vim.cmd("tab drop " .. vim.fn.fnameescape(fname))
              end
              if range then
                local row = range.start.line
                local col = range.start.character
                vim.api.nvim_win_set_cursor(0, { row + 1, col })
              end
            end
          end
        end
      )
    end,
    bufopts
  )
  vim.keymap.set("n", "<leader>gi", "<cmd>tab sb | lua vim.lsp.buf.implementation()<CR>", bufopts)
  vim.keymap.set("n", "<leader>gt", "<cmd>tab sb | lua vim.lsp.buf.type_definition()<CR>", bufopts)
  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
  vim.keymap.set("n", "gd", function() vim.lsp.buf.definition({reuse_win=false}) end, bufopts)
  vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
  vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set("i", "<C-L>h", vim.lsp.buf.hover, bufopts)
  vim.keymap.set("n", "<leader>h", vim.lsp.buf.hover, bufopts)
  vim.keymap.set("n", "<leader>s", vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set("n", "<space>wl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, bufopts)
  vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, bufopts)
  vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
  vim.keymap.set("n", "<space>f", function() vim.lsp.buf.format { async = true } end, bufopts)

  vim.api.nvim_create_autocmd(
    "FileType",
    {
      pattern = "qf",
      callback = function()
        vim.keymap.set("n", "<CR>", ":set switchbuf+=usetab,newtab<CR><CR>:set switchbuf=uselast<CR>", { noremap=true, silent=true, buffer=0 })
        vim.keymap.set("n", "q", ":q<CR>", { noremap=true, silent=true, buffer=0 })
      end
    }
  )
end

return M
