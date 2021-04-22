local utils = require('florentc.utils')

-- builtins

utils.map('n', '<leader>p', '<cmd>lua require("telescope.builtin").git_files()<cr>')
utils.map('n', '<leader>o', '<cmd>lua require("telescope.builtin").find_files()<cr>')
utils.map('n', '<leader>b', '<cmd>lua require("telescope.builtin").buffers()<cr>')
utils.map('n', '<leader>vd', '<cmd>lua require("telescope.builtin").lsp_document_diagnostics()<cr>')

-- personal

utils.map('n', '<leader>vdf', '<cmd>lua require("florentc.telescope").find_dotfiles()<cr>')
utils.map('n', '<leader>vff', '<cmd>lua require("florentc.telescope").find_features()<cr>')

local actions = require('telescope.actions')

require('telescope').setup {
    defaults = {
        prompt_prefix = ' >',
        mappings = {
            i = {
                ["<esc>"] = actions.close
            },
        },
    },
}

local M = {}

M.find_dotfiles = function()
    require("telescope.builtin").find_files({
        prompt_title = "dotfiles",
        cwd = "$HOME/projects/dotfiles",
        hidden = true,
    })
end

-- Search feature files
M.find_features = function()
    require("telescope.builtin").find_files({
        prompt_title = "features",
        hidden = false,
        find_command = { 'fd', '--type', 'f', '-e', 'feature' },
    })
end

return M
