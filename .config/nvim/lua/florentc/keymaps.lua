local utils = require("florentc.utils")

-- Window navigation

-- utils.map("n", "<leader>h", ":wincmd h<cr>")
-- utils.map("n", "<leader>j", ":wincmd j<cr>")
-- utils.map("n", "<leader>k", ":wincmd k<cr>")
-- utils.map("n", "<leader>l", ":wincmd l<cr>")
utils.map("n", "<C-h>", ":wincmd h<cr>")
utils.map("n", "<C-j>", ":wincmd j<cr>")
utils.map("n", "<C-k>", ":wincmd k<cr>")
utils.map("n", "<C-l>", ":wincmd l<cr>")

utils.map("n", "<C-Left>", ":vertical resize +3<cr>")
utils.map("n", "<C-Right>", ":vertical resize -3<cr>")
-- It conflict with vim multi cursor :/
-- utils.map("n", "<C-Up>", ":resize +3<cr>")
-- utils.map("n", "<C-Down>", ":resize -3<cr>")

utils.map("n", "<leader>n", ":bnext<cr>")
utils.map("n", "<leader>N", ":bprev<cr>")

-- Terminal
utils.map("n", "<leader>tt", ":term<cr>")
utils.map("n", "<leader>tv", ":vnew|term<cr>")
utils.map("n", "<leader>th", ":new|term<cr>")

-- utils.map("n", "<leader>rt", ":!go test -v ./...<CR>")
utils.map("n", "<leader>rt", ":!ls -al<CR>")

-- Window control

utils.map("n", "<leader>wo", "<c-w><c-o>")

-- Quickfix list navigation

utils.map("n", "<leader>j", ":cnext<cr>zz")
utils.map("n", "<leader>k", ":cprev<cr>zz")

-- Common (save, close, ...)

utils.map("n", "<leader>s", ":w<cr>")
utils.map("n", "<leader>q", ":bd<cr>")
-- This one is actually better because it keeps window layout
-- utils.map("n", "<leader>q", ":bp\\|bd #<CR>")
utils.map("n", "<leader>ch", ":nohl<cr>")

-- Reload Neovim configuration
utils.map("n", "<leader><cr>", ":luafile ~/.config/nvim/init.lua<cr>")
utils.map("n", "<leader>r", ":source ~/.config/nvim/init.lua<cr>")

-- Exec current lua file

utils.map("n", "<leader>d", ":luafile %<cr>")
utils.map("n", "<leader>af", ":luafile test.lua<cr>")

-- In terminal mode, escape to exit insert mode

utils.map("t", "<Esc>", "<c-\\><c-n>")

-- NvimTree

vim.api.nvim_set_keymap("n", "<leader>vv", ":NvimTreeToggle<CR>", { noremap = true, silent = false })

-- Create a new note

utils.map("n", "<leader>cn", '<cmd>lua require("florentc.keymaps").create_new_note()<cr>')

local M = {}

M.create_new_note = function()
  local noteFolder = "~/projects/notes/content/notes/"
  local name = vim.fn.input("Note name: ")
  if name == "" then
    print("Create note cancelled")
    vim.api.nvim_command("silent")
    return
  end

  local noteFile = noteFolder .. name .. ".md"
  local command = "e " .. noteFile
  vim.api.nvim_command(command)
end

return M
