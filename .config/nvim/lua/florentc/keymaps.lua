local utils = require('florentc.utils')

-- Window navigation

utils.map('n', '<leader>h', ':wincmd h<cr>')
utils.map('n', '<leader>j', ':wincmd j<cr>')
utils.map('n', '<leader>k', ':wincmd k<cr>')
utils.map('n', '<leader>l', ':wincmd l<cr>')

-- Quickfix list navigation

utils.map('n', '<C-j>', ':cnext<cr>')
utils.map('n', '<C-k>', ':cprev<cr>')

-- Common (save, close, ...)

utils.map('n', '<leader>s', ':w<cr>')
utils.map('n', '<leader>q', ':bd<cr>')
-- TODO: How to reload lua config?
utils.map('n', '<leader><cr>', ':luafile ~/.config/nvim/init.lua<cr>')
utils.map('n', '<leader>e', ':e ~/.config/nvim/init.lua<cr>')
-- In terminal mode, escape to exit insert mode
utils.map('t', '<Esc>', '<c-\\><c-n>')
