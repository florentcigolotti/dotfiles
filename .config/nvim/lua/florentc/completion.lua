local utils = require('florentc.utils')
local g = vim.g
local cmd = vim.cmd

utils.map('i', '<S-Tab>', 'pumvisible() ? "\\<C-p>" : "\\<Tab>"', {expr = true})
utils.map('i', '<Tab>', 'pumvisible() ? "\\<C-n>" : "\\<Tab>"', {expr = true})

utils.opt('o', 'completeopt', 'menuone,noinsert,noselect')
cmd [[set shortmess+=c]]
g.completion_confirm_key = ""
g.completion_matching_strategy_list = {'exact', 'substring', 'fuzzy'}
