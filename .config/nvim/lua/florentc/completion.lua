-- local utils = require('florentc.utils')
-- local g = vim.g
-- local cmd = vim.cmd

-- -- Old config using nvim-lua/completion-nvim
--
-- utils.map('i', '<S-Tab>', 'pumvisible() ? "\\<C-p>" : "\\<Tab>"', {expr = true})
-- utils.map('i', '<Tab>', 'pumvisible() ? "\\<C-n>" : "\\<Tab>"', {expr = true})
--
-- utils.opt('o', 'completeopt', 'menuone,noinsert,noselect')
-- cmd [[set shortmess+=c]]
-- g.completion_confirm_key = ""
-- g.completion_matching_strategy_list = {'exact', 'substring', 'fuzzy'}

-- Testing compe

require'compe'.setup {
  enabled = true;
  autocomplete = true;
  debug = false;
  min_length = 1;
  preselect = 'enable';
  throttle_time = 80;
  source_timeout = 200;
  resolve_timeout = 800;
  incomplete_delay = 400;
  max_abbr_width = 100;
  max_kind_width = 100;
  max_menu_width = 100;
  documentation = {
    border = { '', '' ,'', ' ', '', '', '', ' ' }, -- the border option is the same as `|help nvim_open_win|`
    winhighlight = "NormalFloat:CompeDocumentation,FloatBorder:CompeDocumentationBorder",
    max_width = 120,
    min_width = 60,
    max_height = math.floor(vim.o.lines * 0.3),
    min_height = 1,
  };

  source = {
    path = true;
    buffer = true;
    calc = true;
    nvim_lsp = true;
    nvim_lua = true;
    vsnip = false;
    ultisnips = false;
    luasnip = true;
  };
}

local function prequire(...)
    local status, lib = pcall(require, ...)
    if (status) then return lib end
    return nil
end

local luasnip = prequire('luasnip')

local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
    local col = vim.fn.col('.') - 1
    return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
end

_G.tab_complete = function()
    -- If the PopUpMenu is visible return <c-n> (navigation in the popup)
    if vim.fn.pumvisible() == 1 then
        return t "<C-n>"
    -- luasnip control
    elseif luasnip and luasnip.expand_or_jumpable() then
        return t "<Plug>luasnip-expand-or-jump"
    -- If backspace is called, send tab to re-trigger the completion
    elseif check_back_space() then
        return t "<Tab>"
    -- Else call compe complete function
    else
        return vim.fn['compe#complete']()
    end
end
_G.s_tab_complete = function()
    if vim.fn.pumvisible() == 1 then
        return t "<C-p>"
    elseif luasnip and luasnip.jumpable(-1) then
        return t "<Plug>luasnip-jump-prev"
    else
        return t "<S-Tab>"
    end
end

vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})

vim.cmd([[
inoremap <silent><expr> <C-Space> compe#complete()
inoremap <silent><expr> <CR>      compe#confirm('<CR>')
inoremap <silent><expr> <C-e>     compe#close('<C-e>')
inoremap <silent><expr> <C-f>     compe#scroll({ 'delta': +4 })
inoremap <silent><expr> <C-d>     compe#scroll({ 'delta': -4 })
]])

local function copy(args)
	return args[1]
end

local ls = require("luasnip")
local s = ls.snippet
local tn = ls.text_node
local i = ls.insert_node
local f = ls.function_node

ls.snippets = {
	all = {
		-- trigger is fn.
		s("fn", {
			-- Simple static text.
			tn("//Parameters: "),
			-- function, first parameter is the function, second the Placeholders
			-- whose text it gets as input.
			f(copy, 2),
			tn({ "", "function " }),
			-- Placeholder/Insert.
			i(1),
			tn("("),
			-- Placeholder with initial text.
			i(2, "int foo"),
			-- Linebreak
			tn({ ") {", "\t" }),
			-- Last Placeholder, exit Point of the snippet. EVERY 'outer' SNIPPET NEEDS Placeholder 0.
			i(0),
			tn({ "", "}" }),
		}),
		s("class", {
			-- Simple static text.
			tn("//Parameters: "),
			-- function, first parameter is the function, second the Placeholders
			-- whose text it gets as input.
			f(copy, 2),
			tn({ "", "function " }),
			-- Placeholder/Insert.
			i(1),
			tn("("),
			-- Placeholder with initial text.
			i(2, "int foo"),
			-- Linebreak
			tn({ ") {", "\t" }),
			-- Last Placeholder, exit Point of the snippet. EVERY 'outer' SNIPPET NEEDS Placeholder 0.
			i(0),
			tn({ "", "}" }),
		}),
    }
}

-- Extend to vscode snippets
-- vim.o.runtimepath = vim.o.runtimepath..',/Users/florentc/.local/share/nvim/site/pack/paqs/start/friendly-snippets/snippets'
-- require("luasnip/loaders/from_vscode").load()
    require("luasnip/loaders/from_vscode").lazy_load({ path = "/Users/florentc/.local/share/nvim/site/pack/paqs/start/friendly-snippets/snippets"})

