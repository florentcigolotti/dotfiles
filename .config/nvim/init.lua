local cmd = vim.cmd

-- Plugins

cmd 'packadd paq-nvim'
local paq = require('paq-nvim').paq

paq {'nvim-treesitter/nvim-treesitter'}
paq {'neovim/nvim-lspconfig'}
paq {'nvim-lua/completion-nvim'}
paq {'gruvbox-community/gruvbox'}
paq {'nvim-lua/popup.nvim'}
paq {'nvim-lua/plenary.nvim'}
paq {'nvim-telescope/telescope.nvim'}
paq {'mhinz/vim-startify'}
paq {'lewis6991/gitsigns.nvim'}
paq {'kyazdani42/nvim-web-devicons'}
paq {'nvim-treesitter/playground'}
paq {'onsails/lspkind-nvim'}
paq {'hoob3rt/lualine.nvim'}
paq {'mg979/vim-visual-multi'}
paq {'glepnir/lspsaga.nvim'}
paq {'tomtom/tcomment_vim'}
paq {'tpope/vim-fugitive'}
paq {'tjdevries/nlua.nvim'}
paq {'euclidianAce/BetterLua.vim'}
paq {'tjdevries/manillua.nvim'}

-- Global settings

local g = vim.g
local utils = require('florentc.utils')

g.mapleader = " "

-- Import settings

require('florentc.settings')
require('florentc.keymaps')
require('florentc.completion')
require('florentc.lsp')
require('florentc.telescope')
require('florentc.lualine')

-- git signs
require('gitsigns').setup()

-- fugitive
utils.map('n', '<Leader>gs', '<cmd>Gstatus<CR>')
