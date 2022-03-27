local utils = require("florentc.utils")

utils.opt("o", "completeopt", "menu,menuone,noselect")
utils.opt("o", "number", true)
utils.opt("o", "relativenumber", true)
utils.opt("o", "guicursor", "")
utils.opt("o", "showmatch", false)
utils.opt("o", "hlsearch", true)
utils.opt("o", "hidden", true)
utils.opt("o", "errorbells", false)
utils.opt("o", "tabstop", 4)
utils.opt("o", "softtabstop", 4)
utils.opt("o", "shiftwidth", 4)
utils.opt("o", "expandtab", true)
utils.opt("o", "smartindent", true)
utils.opt("o", "nu", true)
utils.opt("o", "wrap", false)
utils.opt("o", "smartcase", true)
utils.opt("o", "swapfile", false)
utils.opt("o", "backup", false)
utils.opt("o", "undodir", vim.env.HOME .. "/.vim/undodir")
utils.opt("o", "undofile", true)
utils.opt("o", "incsearch", true)
utils.opt("o", "termguicolors", true)
utils.opt("o", "scrolloff", 8)
utils.opt("o", "inccommand", "nosplit")
utils.opt("o", "cmdheight", 1)
utils.opt("o", "updatetime", 50)
utils.opt("o", "wrap", true)
utils.opt("o", "splitright", true)

-- highlight line in current buffer only
vim.opt.cursorline = true
local group = vim.api.nvim_create_augroup("CursorLineControl", { clear = true })
local set_cursorline = function(event, value, pattern)
  vim.api.nvim_create_autocmd(event, {
    group = group,
    pattern = pattern,
    callback = function()
      vim.opt_local.cursorline = value
    end,
  })
end
set_cursorline("WinEnter", true)
set_cursorline("WinLeave", false)
set_cursorline("FileType", false, "TelescopePrompt")

-- Use the system clipboard (+)
utils.opt("o", "clipboard", "unnamedplus")

if vim.fn.exists("+termguicolors") then
  utils.opt("o", "termguicolors", true)
end

-- systemd
vim.cmd([[autocmd BufNewFile,BufRead *.service* set ft=systemd]])
-- hosts file
vim.cmd([[autocmd BufNewFile,BufRead hosts set ft=dosini]])

-- Color scheme

require("colorizer").setup()

local default_colors = require("kanagawa.colors").setup()
local my_colors = {
  sumiInk1 = "black",
  fujiWhite = "#EDEDD5",
  bg = "#272727",
  -- popup background
  waveBlue1 = default_colors.sumiInk0,
  -- oniViolet = default_colors.roninYellow,
  oniViolet = default_colors.autumnYellow,
}

require("kanagawa").setup({
  undercurl = true,
  commentStyle = "italic",
  functionStyle = "NONE",
  keywordStyle = "NONE",
  statementStyle = "bold",
  typeStyle = "NONE",
  variablebuiltinStyle = "NONE",
  specialReturn = true,
  specialException = true,
  transparent = false,
  dimInactive = false,
  colors = my_colors,
  overrides = {},
  globalStatus = true,
})

vim.cmd([[colorscheme kanagawa]])
utils.opt("o", "background", "dark")

vim.cmd([[highlight WinSeparator guibg=None guifg=#16161D]])
