local utils = require("florentc.utils")

-- git signs

require("gitsigns").setup({
  keymaps = {
    -- Default keymap options
    noremap = true,
    buffer = true,

    ["n ]c"] = { expr = true, "&diff ? ']c' : '<cmd>lua require\"gitsigns\".next_hunk()<CR>'" },
    ["n [c"] = { expr = true, "&diff ? '[c' : '<cmd>lua require\"gitsigns\".prev_hunk()<CR>'" },

    ["n <leader>ghs"] = '<cmd>lua require"gitsigns".stage_hunk()<CR>',
    ["n <leader>ghu"] = '<cmd>lua require"gitsigns".undo_stage_hunk()<CR>',
    ["n <leader>ghr"] = '<cmd>lua require"gitsigns".reset_hunk()<CR>',
    ["n <leader>ghR"] = '<cmd>lua require"gitsigns".reset_buffer()<CR>',
    ["n <leader>ghp"] = '<cmd>lua require"gitsigns".preview_hunk()<CR>',
    ["n <leader>ghb"] = '<cmd>lua require"gitsigns".blame_line()<CR>',

    -- Text objects
    ["o ih"] = ':<C-U>lua require"gitsigns".select_hunk()<CR>',
    ["x ih"] = ':<C-U>lua require"gitsigns".select_hunk()<CR>',
  },
})

-- fugitive

utils.map("n", "<leader>gl", ":G log<CR>")
utils.map("n", "<Leader>gs", "<cmd>Git<CR>")
utils.map("n", "<Leader>ggs", "<cmd>Git stash<CR>")
utils.map("n", "<Leader>ggp", "<cmd>Git stash pop<CR>")
utils.map("n", "<leader>gp", '<cmd>lua require("florentc.git").git_push_to_current()<cr>')

-- neogit

local neogit = require("neogit")

neogit.setup({})

-- gitlinker

require("gitlinker").setup({
  callbacks = {
    ["cv[-]gitlab.cisco.com"] = function(url_data)
      return require("gitlinker.hosts").get_gitlab_type_url(url_data)
    end,
  },
})

-- Open current selection in browser
utils.map(
  "n",
  "<leader>gY",
  '<cmd>lua require"gitlinker".get_buf_range_url("v", {action_callback = require"gitlinker.actions".open_in_browser})<cr>'
)

-- diffview

require("diffview").setup({
  key_bindings = {
    file_history_panel = { q = "<Cmd>DiffviewClose<CR>" },
    file_panel = { q = "<Cmd>DiffviewClose<CR>" },
    view = { q = "<Cmd>DiffviewClose<CR>" },
  },
})

utils.map("n", "<leader>gd", ":DiffviewOpen<CR>")
utils.map("n", "<leader>gh", ":DiffviewFileHistory<CR>")

local M = {}

M.git_push_to_current = function()
  if vim.fn.input("Confirm Git push? ") == "Y" then
    vim.api.nvim_command("Git -c push.default=current push")
  end
end

return M
