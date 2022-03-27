local utils = require('florentc.utils')

-- Window navigation

utils.map('n', '<leader>h', ':wincmd h<cr>')
utils.map('n', '<leader>j', ':wincmd j<cr>')
utils.map('n', '<leader>k', ':wincmd k<cr>')
utils.map('n', '<leader>l', ':wincmd l<cr>')

-- Window control

utils.map('n', '<leader>wo', '<c-w><c-o>')

-- Quickfix list navigation

utils.map('n', '<C-j>', ':cnext<cr>')
utils.map('n', '<C-k>', ':cprev<cr>')

-- Common (save, close, ...)

utils.map('n', '<leader>s', ':w<cr>')
utils.map('n', '<leader>q', ':bd<cr>')
utils.map('n', '<leader>ch', ':nohl<cr>')

-- Reload Neovim configuration, work only if using plenary.reload:
-- require('plenary.reload').reload_module('florentc', true)

utils.map('n', '<leader><cr>', ':luafile ~/.config/nvim/init.lua<cr>')
utils.map('n', '<leader>r', ':source ~/.config/nvim/init.lua<cr>')

-- Edit init.lua

utils.map('n', '<leader>e', ':e ~/.config/nvim/init.lua<cr>')

-- Exec current lua file

utils.map('n', '<leader>d', ':luafile %<cr>')

-- In terminal mode, escape to exit insert mode

utils.map('t', '<Esc>', '<c-\\><c-n>')



