return require('packer').startup(function()
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  use 'nvim-treesitter/nvim-treesitter'
  use 'nvim-treesitter/nvim-treesitter-textobjects'
  use 'neovim/nvim-lspconfig'
  -- use 'nvim-lua/completion-nvim'
  use 'gruvbox-community/gruvbox'
  use 'nvim-lua/popup.nvim'
  use 'nvim-lua/plenary.nvim'

  -- use 'nvim-telescope/telescope.nvim'
  use '/Users/florentc/projects/perso/telescope.nvim'
  use 'nvim-telescope/telescope-project.nvim'

  -- use 'mhinz/vim-startify'
  use 'lewis6991/gitsigns.nvim'
  use 'kyazdani42/nvim-web-devicons'
  use 'nvim-treesitter/playground'
  use 'onsails/lspkind-nvim'
  use 'hoob3rt/lualine.nvim'
  use 'mg979/vim-visual-multi'
  use 'glepnir/lspsaga.nvim'
  use 'tomtom/tcomment_vim'
  use 'tpope/vim-fugitive'
  use 'tpope/vim-surround'
  use 'tjdevries/nlua.nvim'
  use 'euclidianAce/BetterLua.vim'
  use 'tjdevries/manillua.nvim'
  -- use 'kyazdani42/nvim-tree.lua'
  use 'jiangmiao/auto-pairs'
  use 'shumphrey/fugitive-gitlab.vim'
  use 'michaeljsmith/vim-indent-object'
  use 'editorconfig/editorconfig-vim'

  use {
    'akinsho/nvim-bufferline.lua',
    config = function()
      require('bufferline').setup{
        options = {
          view = "default",
          numbers = "none",
          buffer_close_icon= '',
          modified_icon = '●',
          close_icon = '',
          left_trunc_marker = '',
          right_trunc_marker = '',
          max_name_length = 18,
          max_prefix_length = 15, -- prefix used when a buffer is deduplicated
          tab_size = 18,
          diagnostics = "nvim_lsp",
          separator_style = "slant",
        }
      }
    end
  }

  use {
    'folke/lsp-trouble.nvim',
    config = function()
      require("trouble").setup {
        position = "bottom", -- position of the list can be: bottom, top, left, right
        height = 10, -- height of the trouble list when position is top or bottom
        width = 50, -- width of the list when position is left or right
        icons = true, -- use devicons for filenames
        mode = "lsp_workspace_diagnostics", -- "lsp_workspace_diagnostics", "lsp_document_diagnostics", "quickfix", "lsp_references", "loclist"
        fold_open = "", -- icon used for open folds
        fold_closed = "", -- icon used for closed folds
        action_keys = { -- key mappings for actions in the trouble list
          -- map to {} to remove a mapping, for example:
          -- close = {},
          close = "q", -- close the list
          cancel = "<esc>", -- cancel the preview and get back to your last window / buffer / cursor
          refresh = "r", -- manually refresh
          jump = {"<cr>", "<tab>"}, -- jump to the diagnostic or open / close folds
          open_split = { "<c-x>" }, -- open buffer in new split
          open_vsplit = { "<c-v>" }, -- open buffer in new vsplit
          open_tab = { "<c-t>" }, -- open buffer in new tab
          jump_close = {"o"}, -- jump to the diagnostic and close the list
          toggle_mode = "m", -- toggle between "workspace" and "document" diagnostics mode
          toggle_preview = "P", -- toggle auto_preview
          hover = "K", -- opens a small popup with the full multiline message
          preview = "p", -- preview the diagnostic location
          close_folds = {"zM", "zm"}, -- close all folds
          open_folds = {"zR", "zr"}, -- open all folds
          toggle_fold = {"zA", "za"}, -- toggle fold of current file
          previous = "k", -- preview item
          next = "j" -- next item
        },
        indent_lines = true, -- add an indent guide below the fold icons
        auto_open = false, -- automatically open the list when you have diagnostics
        auto_close = false, -- automatically close the list when you have no diagnostics
        auto_preview = false, -- automatically preview the location of the diagnostic. <esc> to close preview and go back to last window
        auto_fold = false, -- automatically fold a file trouble list at creation
        signs = {
          -- icons / text used for a diagnostic
          error = "",
          warning = "",
          hint = "",
          information = "",
          other = "﫠"
        },
        use_lsp_diagnostic_signs = false -- enabling this will use the signs defined in your lsp client
      }
    end
  }
  use 'kergoth/vim-bitbake'
  use 'nvim-lua/lsp_extensions.nvim'
  use 'fatih/vim-go'

  -- Plugin in testing

  use 'rcarriga/nvim-notify'
  use 'camspiers/snap'
  use 'junegunn/fzf'
  use 'junegunn/fzf.vim'
  use 'L3MON4D3/LuaSnip'
  use 'hrsh7th/nvim-compe'
  use 'rafamadriz/friendly-snippets'
  use 'TimUntersberger/neogit'
  use {
    "rcarriga/nvim-dap-ui",
    requires = {"mfussenegger/nvim-dap", "theHamsta/nvim-dap-virtual-text"},
    config = function()
      require("dapui").setup({
        icons = {
          expanded = "▾",
          collapsed = "▸"
        },
        mappings = {
          -- Use a table to apply multiple mappings
          expand = {"<CR>", "<2-LeftMouse>", "<TAB>"},
          open = "o",
          remove = "d",
          edit = "e",
          repl = "r",
        },
        sidebar = {
          elements = {
            -- You can change the order of elements in the sidebar
            "scopes",
            "breakpoints",
            "stacks",
            "watches"
          },
          size = 40,
          position = "left" -- Can be "left" or "right"
        },
        tray = {
          elements = {
            "repl"
          },
          size = 10,
          position = "bottom" -- Can be "bottom" or "top"
        },
        floating = {
          max_height = nil, -- These can be integers or a float between 0 and 1.
          max_width = nil   -- Floats will be treated as percentage of your screen.
        }
      })
      -- Activate dap virtual text
      vim.g.dap_virtual_text = true
    end,
  }

  use {
    'ray-x/lsp_signature.nvim',
    config = function()

    end,
  }

  use {
    'kevinhwang91/nvim-bqf',
    config = function()
    end,
  }

  use {
    'nvim-telescope/telescope-fzf-native.nvim',
    run = 'make',
    config = function()

    end,
  }
end)

