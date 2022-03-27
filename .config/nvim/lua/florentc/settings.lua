local utils = require('florentc.utils')

local g = vim.g
local cmd = vim.cmd

g.mapleader = " "

utils.opt('o', 'number', true)
utils.opt('o', 'relativenumber', true)
utils.opt('o', 'guicursor', '')
utils.opt('o', 'showmatch', false)
utils.opt('o', 'hlsearch', true)
utils.opt('o', 'hidden', true)
utils.opt('o', 'errorbells', false)
utils.opt('o', 'tabstop', 4)
utils.opt('o', 'softtabstop', 4)
utils.opt('o', 'shiftwidth', 4)
utils.opt('o', 'expandtab', true)
utils.opt('o', 'smartindent', true)
utils.opt('o', 'nu', true)
utils.opt('o', 'wrap', false)
utils.opt('o', 'smartcase', true)
utils.opt('o', 'swapfile', false)
utils.opt('o', 'backup', false)
utils.opt('o', 'undodir', vim.env.HOME..'/.vim/undodir')
utils.opt('o', 'undofile', true)
utils.opt('o', 'incsearch', true)
utils.opt('o', 'termguicolors', true)
utils.opt('o', 'scrolloff', 8)
utils.opt('o', 'inccommand', 'nosplit')
utils.opt('o', 'cmdheight', 1)
utils.opt('o', 'updatetime', 50)

-- Use the system clipboard (+)
utils.opt('o', 'clipboard', 'unnamedplus')

if vim.fn.exists('+termguicolors') then
    -- vim.api.nvim_eval('let &t_8f = "\\<Esc>[38;2;%lu;%lu;%lum"')
    -- vim.api.nvim_eval('let &t_8b = "\\<Esc>[48;2;%lu;%lu;%lum"')
    utils.opt('o', 'termguicolors', true)
end

-- Color scheme

cmd([[colorscheme gruvbox]])
g.gruvbox_contrast_dark = 'hard'
utils.opt('o', 'background', 'dark')
