local utils = require('florentc.utils')

-- Treesitter

require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained",
  highlight = {
    enable = true,
  },
  textobjects = {
    select = {
      enable = true,
      keymaps = {
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        ["]]"] = "@function.outer",
        -- ["]]"] = "@class.outer",
      },
      goto_next_end = {
        ["]["] = "@function.outer",
        -- ["]["] = "@class.outer",
      },
      goto_previous_start = {
        ["[["] = "@function.outer",
        -- ["[["] = "@class.outer",
      },
      goto_previous_end = {
        ["[]"] = "@function.outer",
        -- ["[]"] = "@class.outer",
      },
    },
  },
}

-- LSP configuration
--
-- LSPKind
require('lspkind').init({
    -- enables text annotations
    --
    -- default: true
    with_text = true,

    -- default symbol map
    -- can be either 'default' (requires nerd-fonts font) or
    -- 'codicons' for codicon preset (requires vscode-codicons font)
    --
    -- default: 'default'
    preset = 'codicons',

    -- override preset symbols
    --
    -- default: {}
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
      TypeParameter = ""
    },
})

local lspconfig = require('lspconfig')

local on_attach = function(client, bufnr)
  require "lsp_signature".on_attach({
      bind = true, -- This is mandatory, otherwise border config won't get registered.
      handler_opts = {
        border = "single"
      }
    }
  )

  -- require'completion'.on_attach(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings
  local opts = { noremap=true, silent=true }
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)

  -- TODO: testing replacement of this binding with LSPsaga hover_doc
  --buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'K', ':Lspsaga hover_doc<cr>', opts)

  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  -- buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)

  -- TODO: experiment with builtin and telescope find ref
  -- buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', 'gR', '<cmd>lua require("telescope.builtin").lsp_references()<CR>', opts)

  -- buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  -- buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)

  -- Set some keybinds conditional on server capabilities
  if client.resolved_capabilities.document_formatting then
    buf_set_keymap("n", "<space>ff", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
  elseif client.resolved_capabilities.document_range_formatting then
    buf_set_keymap("n", "<space>ff", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
  end

  -- Set autocommands conditional on server_capabilities
  if client.resolved_capabilities.document_highlight then
    vim.api.nvim_exec([[
      hi LspReferenceRead cterm=bold ctermbg=red guibg=#3c3836
      hi LspReferenceText cterm=bold ctermbg=red guibg=#3c3836
      hi LspReferenceWrite cterm=bold ctermbg=red guibg=#3c3836
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]], false)
  end
end

-- Use a loop to conveniently both setup defined servers
-- and map buffer local keybindings when the language server attaches
local servers = { "pyright", "rust_analyzer", "tsserver", "eslint",  "gopls", "bashls", "clangd" }
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup { on_attach = on_attach }
end

require('nlua.lsp.nvim').setup(require('lspconfig'), {
  on_attach = on_attach,
  -- Include globals you want to tell the LSP are real :)
  globals = {
    -- Colorbuddy
    "Color", "c", "Group", "g", "s",
  }
})

-- golangci-lint

local configs = require('lspconfig/configs')

if not lspconfig.golangcilsp then
  configs.golangcilsp = {
    default_config = {
      cmd = {'golangci-lint-langserver'},
      root_dir = lspconfig.util.root_pattern('.git', 'go.mod'),
      init_options = {
        command = { "golangci-lint", "run", "--enable-all", "--disable", "lll", "--out-format", "json" };
      }
    };
  }
end

lspconfig.golangcilsp.setup {
	filetypes = {'go'}
}

-- jsonlsp

require('lspconfig').jsonls.setup {
  commands = {
    Format = {
      function()
        vim.lsp.buf.range_formatting({},{0,0},{vim.fn.line("$"),0})
      end
    }
  }
}

-- lsp saga

require("lspsaga").init_lsp_saga({
  error_sign = "",
  warn_sign = "",
  hint_sign = "",
  infor_sign = "",
})

utils.map('n', '<silent>gh', '<cmd>lua require"lspsaga.provider".lsp_finder()')
-- utils.map('n', '<silent><C-f>', '<cmd>lua require("lspsaga.action").smart_scroll_with_saga(1)<cr>')
-- utils.map('n', '<silent><C-b>', '<cmd>lua require("lspsaga.action").smart_scroll_with_saga(-1)<cr>')

-- diagnosticls for shellcheck

lspconfig.diagnosticls.setup{
    filetypes = { "sh" },
    init_options = {
        filetypes = {
            sh = "shellcheck"
        },
        linters = {
            shellcheck = {
                sourceName = "shellcheck",
                command = "shellcheck",
                debounce = 100,
                args = { "--format=gcc", "-" },
                offsetLine = 0,
                offsetColumn = 0,
                formatLines = 1,
                formatPattern = {
                    "^[^:]+:(\\d+):(\\d+):\\s+([^:]+):\\s+(.*)$",
                    {
                        line = 1,
                        column = 2,
                        message = 4,
                        security = 3
                    };
                },
                securities = {
                    error = "error",
                    warning = "warning",
                    note = "info"
                };
            }
        }
    }
}

-- LspTrouble

utils.map('n', "<leader>xx", "<cmd>LspTroubleToggle<cr>", { silent = true })
utils.map('n', "<leader>xw", "<cmd>LspTroubleToggle lsp_workspace_diagnostics<cr>", { silent = true })
utils.map('n', "<leader>xd", "<cmd>LspTroubleToggle lsp_document_diagnostics<cr>", { silent = true })
utils.map('n', "<leader>xl", "<cmd>LspTroubleToggle loclist<cr>", { silent = true })
utils.map('n', "<leader>xq", "<cmd>LspTroubleToggle quickfix<cr>", { silent = true })
utils.map('n', "gr", "<cmd>LspTroubleToggle lsp_references<cr>", { silent = true })

-- lsp extensions

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  require('lsp_extensions.workspace.diagnostic').handler, {
    -- underline = false,
    signs = {
      severity_limit = "Error",
    },
    -- update_in_insert = false,
  }
)

-- Get the counts from your curreent workspace:
-- local ws_errors = require('lsp_extensions.workspace.diagnostic').get_count(0, 'Error')
-- local ws_hints = require('lsp_extensions.workspace.diagnostic').get_count(0, 'Hint')

-- Set the qflist for the current workspace
--  For more information, see `:help vim.lsp.diagnostic.set_loc_list()`, since this has some of the same configuration.
-- require('lsp_extensions.workspace.diagnostic').set_qf_list()

-- terraform

require'lspconfig'.terraformls.setup{}

local dap, dapui = require('dap'), require('dapui')
dap.listeners.after.event_initialized['dapui_config'] = function() dapui.open() end
dap.listeners.before.event_terminated['dapui_config'] = function() dapui.close() end
dap.listeners.before.event_exited['dapui_config'] = function() dapui.close() end
