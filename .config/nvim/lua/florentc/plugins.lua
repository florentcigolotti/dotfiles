return require("packer").startup(function(use)
  use("wbthomason/packer.nvim")

  -- Core tools
  use("nvim-lua/plenary.nvim")

  -- Treesitter
  use("nvim-treesitter/playground")
  use("nvim-treesitter/nvim-treesitter")
  use("nvim-treesitter/nvim-treesitter-textobjects")

  -- Visual
  use("nvim-lua/popup.nvim")
  use("norcalli/nvim-colorizer.lua")
  use("kyazdani42/nvim-web-devicons")
  use("rcarriga/nvim-notify")
  -- Themes
  use("rebelot/kanagawa.nvim")
  -- Top / Bottom lines
  use("nvim-lualine/lualine.nvim")
  use("akinsho/nvim-bufferline.lua")

  -- Completion
  use({
    "hrsh7th/nvim-cmp",
    requires = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-calc",
      "saadparwaiz1/cmp_luasnip",
    },
  })

  -- Telescope
  use("nvim-telescope/telescope-project.nvim")
  use({
    "nvim-telescope/telescope-fzf-native.nvim",
    run = "make",
  })
  use({
    "rmagatti/session-lens",
    requires = { "rmagatti/auto-session", "nvim-telescope/telescope.nvim" },
    config = function()
      require("session-lens").setup()
    end,
  })
  use("jvgrootveld/telescope-zoxide")
  use({
    "dhruvmanila/telescope-bookmarks.nvim",
    requires = {
      "tami5/sqlite.lua",
    },
    commit = "eef8e53885525a6f2ddf98bff6b9fe17c263db6e",
  })

  -- Git
  use("lewis6991/gitsigns.nvim")
  use("ruifm/gitlinker.nvim")
  use("tpope/vim-fugitive")
  use("sindrets/diffview.nvim")
  use("rhysd/committia.vim")

  -- lsp
  use("neovim/nvim-lspconfig")
  use("onsails/lspkind-nvim")
  use("folke/trouble.nvim")
  use("j-hui/fidget.nvim")
  use("jose-elias-alvarez/null-ls.nvim")
  use("williamboman/nvim-lsp-installer")
  use("L3MON4D3/LuaSnip")
  use("ray-x/lsp_signature.nvim")

  -- Utils
  use({
    "kyazdani42/nvim-tree.lua",
    config = function()
      require("nvim-tree").setup()
    end,
  })
  use("mg979/vim-visual-multi")
  use("tomtom/tcomment_vim")
  use({
    "tpope/vim-surround",
    requires = { "tpope/vim-repeat" },
  })
  use("windwp/nvim-autopairs")
  use("michaeljsmith/vim-indent-object")
  use("editorconfig/editorconfig-vim")
  use("lewis6991/impatient.nvim")

  -- Dev
  -- Lua
  use("folke/lua-dev.nvim")
  -- Golang
  -- use("fatih/vim-go")
  -- Bitbake
  use("kergoth/vim-bitbake")
  -- Helm
  use("towolf/vim-helm")
  -- Cue
  use("jjo/vim-cue")
  -- Debugging
  use({
    "rcarriga/nvim-dap-ui",
    requires = { "mfussenegger/nvim-dap", "theHamsta/nvim-dap-virtual-text", "mfussenegger/nvim-dap-python" },
  })
  use("jbyuki/one-small-step-for-vimkind")

  -- Testing zone
  -- use("tami5/lspsaga.nvim")
  use("ThePrimeagen/harpoon")
  use("TimUntersberger/neogit")
  use("luukvbaal/nnn.nvim")
  use("rafamadriz/friendly-snippets")
end)
