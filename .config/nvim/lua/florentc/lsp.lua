local utils = require("florentc.utils")

-- Set diagnistic signs
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

-- LSPKind
require("lspkind").init({
  preset = "codicons",
  mode = "symbol_text",
  symbol_map = {
    Text = "",
    Method = "",
    Function = "",
    Constructor = "",
    Field = "ﰠ",
    Variable = "",
    Class = "ﴯ",
    Interface = "",
    Module = "",
    Property = "ﰠ",
    Unit = "塞",
    Value = "",
    Enum = "",
    Keyword = "",
    Snippet = "",
    Color = "",
    File = "",
    Reference = "",
    Folder = "",
    EnumMember = "",
    Constant = "",
    Struct = "פּ",
    Event = "",
    Operator = "",
    TypeParameter = "",
  },
})

local on_attach = function(client, bufnr)
  -- Disable formatting capabilities for tsserver to use only null-ls provider
  if client.name == "tsserver" then
    client.resolved_capabilities.document_formatting = false
    client.resolved_capabilities.document_range_formatting = false
  end

  require("lsp_signature").on_attach({
    bind = true,
    handler_opts = {
      border = "single",
    },
  })

  local function buf_set_keymap(...)
    vim.api.nvim_buf_set_keymap(bufnr, ...)
  end
  local function buf_set_option(...)
    vim.api.nvim_buf_set_option(bufnr, ...)
  end

  buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

  -- Mappings
  local opts = { noremap = true, silent = true }
  buf_set_keymap("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts)
  buf_set_keymap("n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
  buf_set_keymap("n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>", opts)
  buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
  -- Disable this one because C-k is used for quickfix jumps
  -- buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap("n", "<space>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
  buf_set_keymap("n", "<space>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
  buf_set_keymap("n", "<space>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts)
  buf_set_keymap("n", "<space>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
  buf_set_keymap("n", "<space>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
  buf_set_keymap("n", "<space>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
  -- TODO: experiment with builtin and telescope find ref
  buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
  buf_set_keymap("n", "gR", '<cmd>lua require("telescope.builtin").lsp_references()<CR>', opts)
  buf_set_keymap("n", "<space>m", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
  buf_set_keymap("n", "<leader>dp", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
  buf_set_keymap("n", "<leader>dn", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
  -- buf_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.set_loclist()<CR>', opts)

  -- Set some keybinds conditional on server capabilities
  if client.resolved_capabilities.document_formatting then
    buf_set_keymap("n", "<space>fd", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
  elseif client.resolved_capabilities.document_range_formatting then
    buf_set_keymap("n", "<space>ff", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
  end

  -- Set autocommands conditional on server_capabilities
  if client.resolved_capabilities.document_highlight then
    vim.api.nvim_exec(
      [[
      hi LspReferenceRead cterm=bold ctermbg=red guibg=#3c3836
      hi LspReferenceText cterm=bold ctermbg=red guibg=#3c3836
      hi LspReferenceWrite cterm=bold ctermbg=red guibg=#3c3836
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]],
      false
    )
  end
end

-- For jsonls to work, we need to specify snippet capability
local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())
capabilities.textDocument.completion.completionItem.snippetSupport = true

-- lsp-installer

local lsp_installer = require("nvim-lsp-installer")
lsp_installer.on_server_ready(function(server)
  local settings = nil

  if server.name == "sumneko_lua" then
    settings = require("lua-dev").setup().settings
  end

  if server.name == "gopls" then
    settings = {
      gopls = {
        -- Use gopls builtin gofumpt
        gofumpt = true,
      },
    }
  end

  server:setup({
    settings = settings,
    on_attach = on_attach,
    capabilities = capabilities,
    flags = {
      debounce_text_changes = 150,
    },
  })
end)

-- Golang

-- See here: https://github.com/golang/tools/blob/master/gopls/doc/vim.md#imports
function OrgImports(wait_ms)
  local params = vim.lsp.util.make_range_params()
  params.context = { only = { "source.organizeImports" } }
  local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, wait_ms)
  for _, res in pairs(result or {}) do
    for _, r in pairs(res.result or {}) do
      if r.edit then
        vim.lsp.util.apply_workspace_edit(r.edit, "utf-8")
      else
        vim.lsp.buf.execute_command(r.command)
      end
    end
  end
end

vim.api.nvim_create_augroup("goFileType", { clear = true })
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.go",
  callback = function()
    vim.lsp.buf.formatting()
  end,
})
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.go",
  callback = function()
    OrgImports(1000)
  end,
})

-- null-ls

require("null-ls").setup({
  log = {
    enable = true,
    level = "warn",
    use_console = "async",
  },
  on_attach = on_attach,
  sources = {
    -- lua
    require("null-ls").builtins.formatting.stylua,
    require("null-ls").builtins.diagnostics.selene,
    -- bash
    require("null-ls").builtins.diagnostics.shellcheck,
    require("null-ls").builtins.formatting.shellharden,
    -- js and co
    require("null-ls").builtins.formatting.prettier,
    -- python
    require("null-ls").builtins.formatting.isort,
    require("null-ls").builtins.formatting.black,
    -- yaml
    require("null-ls").builtins.diagnostics.yamllint,
  },
})

local null_ls = require("null-ls")

-- Custom null-ls diagnistic with treesitter

local testrail_tc_duplicate_detector = {
  method = null_ls.methods.DIAGNOSTICS,
  filetypes = { "javascript" },
  generator = {
    fn = function(params)
      local diagnostics = {}

      local ts = vim.treesitter
      local ts_utils = require("nvim-treesitter.ts_utils")

      local query = [[
  (call_expression
    function: (identifier) @func
    (#match? @func "it")
    arguments: (arguments
      (string
        (string_fragment) @text)) @args)
]]

      local parsed_query = ts.parse_query(params.ft, query)
      local parser = ts.get_parser(params.bufnr)
      local root = parser:parse()[1]:root()
      local start_row, _, end_row, _ = root:range()

      -- Iter over captures
      for id, node in parsed_query:iter_captures(root, params.bufnr, start_row, end_row) do
        local name = parsed_query.captures[id] -- name of the capture in the query

        -- Working on @args only
        if name == "args" then
          -- Do work only on "it" functions with 3 arguments
          if node:named_child_count() == 3 then
            -- Gets all named children of the arguments node which gives a table of all arguments
            local args = ts_utils.get_named_children(node)

            -- Check args types
            if args[1]:type() == "array" and args[2]:type() == "string" and args[3]:type() == "arrow_function" then
              local arg1 = args[1]
              local arg1_children = ts_utils.get_named_children(arg1)

              local array_case_id = nil

              -- Inspect the array
              for _, element in ipairs(arg1_children) do
                local e_content = ts_utils.get_named_children(element)
                local value = ts_utils.get_node_text(e_content[1])
                array_case_id = value[1]
              end

              if array_case_id ~= nil then
                -- Get arg2 content
                local arg2_content = ts_utils.get_node_text(args[2])[1]

                if string.find(arg2_content, array_case_id) then
                  local error_msg = "More than 1 definition of the case id " .. array_case_id

                  local row, start_col, _, end_col = node:range()

                  table.insert(diagnostics, {
                    row = row + 1,
                    col = start_col - 1,
                    end_col = end_col - 1,
                    source = "testrail_tc_duplicate_detector",
                    message = error_msg,
                    severity = 2,
                  })
                end
              end
            end
          end
        end
      end

      return diagnostics
    end,
  },
}

null_ls.register(testrail_tc_duplicate_detector)

-- Trouble

utils.map("n", "<leader>xx", "<cmd>TroubleToggle<cr>", { silent = true })
utils.map("n", "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>", { silent = true })
utils.map("n", "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>", { silent = true })
utils.map("n", "<leader>xl", "<cmd>TroubleToggle loclist<cr>", { silent = true })
utils.map("n", "<leader>xq", "<cmd>TroubleToggle quickfix<cr>", { silent = true })
-- utils.map("n", "gr", "<cmd>TroubleToggle lsp_references<cr>", { silent = true })

-- fidget for lsp progress feedback

require("fidget").setup({})
