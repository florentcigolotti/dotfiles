require("impatient")

vim.g.mapleader = " "

-- Plugins

-- Allow reloading with <leader><cr> for lua/florentc/*.lua files
-- The only error I get is from fidget widget when lsp client are
-- killed (one error for each client)
require("plenary.reload").reload_module("florentc", true)

require("florentc.globals")
require("florentc.plugins")
require("florentc.settings")
require("florentc.keymaps")
require("florentc.completion")
require("florentc.lsp")
require("florentc.telescope")
require("florentc.lualine")
require("florentc.dap")
require("florentc.git")
require("florentc.format")
require("florentc.treesitter")
require("florentc.session")
require("florentc.nnn")
require("florentc.utils")
require("florentc.bufferline")
require("florentc.trouble")

-- It causes: https://github.com/rmagatti/auto-session/issues/64
-- See also https://github.com/neovim/neovim/issues/11330
-- and https://github.com/neovim/neovim/issues/15044
-- vim.notify = require("notify")

require("nvim-autopairs").setup({
  disable_filetype = { "TelescopePrompt", "vim" },
})

-- Global status line
-- Don't what going on but if set in settings.lua it does not work...
vim.opt.laststatus = 3
vim.opt.fillchars:append({
  horiz = "━",
  horizup = "┻",
  horizdown = "┳",
  vert = "┃",
  vertleft = "┨",
  vertright = "┣",
  verthoriz = "╋",
})

-- VisualMulti
-- vim.api.nvim_set_var("VM_maps", {
--   ["Add Cursor Up"] = "C-Up",
--   ["Add Cursor Down"] = "C-Down",
-- })
