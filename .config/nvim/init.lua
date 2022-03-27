-- Global settings

vim.o.completeopt = "menuone,noselect"
vim.g.mapleader = " "

-- Plugins

require('florentc.plugins') require('plenary.reload').reload_module('florentc', true)

-- Import settings

require('florentc.settings')
require('florentc.keymaps')
require('florentc.completion')
require('florentc.lsp')
require('florentc.telescope')
require('florentc.lualine')
require('florentc.dap')
require('florentc.git')

-- Global debug functions

function _G.dump(...)
  local objects = vim.tbl_map(vim.inspect, {...})
  print(unpack(objects))
  return ...
end

vim.notify = require("notify")
