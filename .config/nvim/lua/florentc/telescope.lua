local utils = require("florentc.utils")

-- builtins

utils.map("n", "<leader>o", '<cmd>lua require("telescope.builtin").find_files()<cr>')
utils.map("n", "<leader>b", '<cmd>lua require("telescope.builtin").buffers()<cr>')
utils.map("n", "<leader>vd", '<cmd>lua require("telescope.builtin").diagnostics()<cr>')
utils.map("n", "<leader>gb", '<cmd>lua require("telescope.builtin").git_branches()<cr>')
utils.map("n", "<leader>fg", '<cmd>lua require("telescope.builtin").live_grep { hidden = false }<cr>')
utils.map("n", "<leader>i", '<cmd>lua require("telescope.builtin.lsp").document_symbols()<cr>')
utils.map("n", "<leader>u", '<cmd>lua require("telescope.builtin.lsp").dynamic_workspace_symbols()<cr>')
utils.map("n", "<leader>fw", ":Telescope grep_string search=<C-R><C-W><CR>")
utils.map("n", "<leader>fp", ":lua require'telescope'.extensions.project.project{}<CR>")
utils.map("n", "<leader>fh", '<cmd>lua require("telescope.builtin").help_tags()<cr>')
utils.map("n", "<leader>fm", '<cmd>lua require("telescope.builtin").keymaps()<cr>')
utils.map("n", "<leader>e", '<cmd>lua require("telescope.builtin").commands()<cr>')

utils.map("v", "<C-f>", 'y<ESC><cmd>lua require("telescope.builtin").live_grep { default_text = "<C-R>0" }<CR>', {
  noremap = true,
  silent = true,
})

-- personal

utils.map("n", "<leader>p", '<cmd>lua require("florentc.telescope").project_files()<cr>')
utils.map("n", "<leader>df", '<cmd>lua require("florentc.telescope").find_nvim_files()<cr>')
utils.map("n", "<leader>fn", '<cmd>lua require("florentc.telescope").find_notes()<cr>')
-- utils.map("n", "<leader>ff", '<cmd>lua require("florentc.telescope").find_features()<cr>')
utils.map("n", "<leader>fe", '<cmd>lua require("florentc.telescope").find_envs()<cr>')

-- Plugins

utils.map("n", "<leader>fs", '<cmd>lua require("session-lens").search_session()<cr>')
utils.map("n", "<leader>ff", '<cmd>lua require("telescope").extensions.bookmarks.bookmarks()<cr>')
utils.map("n", "<leader>cd", '<cmd>lua require("telescope").extensions.zoxide.list{}<cr>')

local actions = require("telescope.actions")

local previewers = require("telescope.previewers")
local previewers_utils = require("telescope.previewers.utils")

local max_size = 100000
local truncate_large_files = function(filepath, bufnr, opts)
  opts = opts or {}

  filepath = vim.fn.expand(filepath)
  vim.loop.fs_stat(filepath, function(_, stat)
    if not stat then
      return
    end
    if stat.size > max_size then
      local cmd = { "head", "-c", max_size, filepath }
      previewers_utils.job_maker(cmd, bufnr, opts)
    else
      previewers.buffer_previewer_maker(filepath, bufnr, opts)
    end
  end)
end

require("telescope").setup({
  defaults = {
    layout_strategy = "horizontal",
    prompt_prefix = " >",
    buffer_previewer_maker = truncate_large_files,
    -- file_sorter =  require'telescope.sorters'.get_fzy_sorter,
    -- generic_sorter =  require'telescope.sorters'.get_fzy_sorter,
    file_ignore_patterns = {".git/"},
    mappings = {
      i = {
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        -- ["<esc>"] = actions.close,
      },
    },
    preview = {
      treesitter = false,
    },
  },
  pickers = {
    buffers = {
      sort_lastused = true,
      -- show_all_buffers = false,
      -- theme = "dropdown",
      -- previewer = false,
      mappings = {
        i = {
          ["<c-d>"] = require("telescope.actions").delete_buffer,
        },
        n = {
          ["<c-d>"] = require("telescope.actions").delete_buffer,
        },
      },
    },
    live_grep = {
      additional_args = function()
        return {
          "--hidden",
        }
      end,
    },
  },
  extensions = {
    fzf = {
      fuzzy = false, -- false will only do exact matching
      override_generic_sorter = true, -- override the generic sorter
      override_file_sorter = true, -- override the file sorter
      case_mode = "smart_case", -- or "ignore_case" or "respect_case"
    },
    project = {
      base_dirs = {
        { "~/hades", max_depth = 2 },
        { "~/hades/go/src/sentryo.net", max_depth = 2 },
      },
    },
    bookmarks = {
      -- Available: 'brave', 'chrome', 'edge', 'firefox', 'safari'
      selected_browser = "firefox",
      url_open_command = "open",
      url_open_plugin = nil,
      full_path = true,
      -- firefox_profile_name = "default-release",
      firefox_profile_name = "tgar47sd.default-release",
    },
  },
})

require("telescope").load_extension("fzf")
require("telescope").load_extension("project")
require("telescope").load_extension("zoxide")
require("telescope").load_extension("bookmarks")
require("telescope").load_extension("notify")

local M = {}

M.find_nvim_files = function()
  require("telescope.builtin").find_files({
    prompt_title = "dotfiles",
    cwd = "$HOME/projects/perso/dotfiles/.config/nvim",
    find_command = { "fd", "--type", "f", "-uu", "-E", "packer_compiled.lua" },
    hidden = true,
  })
end

M.find_notes = function()
  require("telescope.builtin").find_files({
    prompt_title = "notes",
    cwd = "$HOME/projects/notes/content",
    hidden = true,
  })
end

-- Search feature files
M.find_features = function()
  require("telescope.builtin").find_files({
    prompt_title = "features",
    hidden = false,
    find_command = { "fd", "--type", "f", "-e", "feature" },
  })
end

-- Search envs files
M.find_envs = function()
  require("telescope.builtin").find_files({
    prompt_title = "envs",
    hidden = false,
    find_command = { "fd", "--type", "f", "-e", "json", "-uu" },
    cwd = "$HOME/projects/ccv-qa/e2e-tests/infra/envs",
  })
end

M.project_files = function()
  local opts = {}
  local ok = pcall(require("telescope.builtin").git_files, opts)
  if not ok then
    require("telescope.builtin").find_files(opts)
  end
end

return M
