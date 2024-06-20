local plugins = {
  -- color
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      -- catppuccin-latte, catppuccin-frappe, catppuccin-macchiato, catppuccin-mocha
      vim.cmd("colorscheme catppuccin-frappe")
    end
  },

  -- parsing
  {
    'nvim-treesitter/nvim-treesitter',
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = { "c", "cpp", "glsl" ,"lua", "vim", "vimdoc", "query", "rust", "swift" },
      })
    end
  },

  -- navigation
  {
    'nvim-telescope/telescope.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' }
  },

  -- formatting
  {
    'stevearc/conform.nvim',
    config = function()
      require("conform").setup({
        formatters_by_ft = {
          lua = { "stylua" },
          cpp = { "clang-format" }
        },
      })
    end
  },

  -- comment code
  {
    'numToStr/Comment.nvim',
  },

  -- auto pairs
  {
    "echasnovski/mini.pairs",
    version = '*',
    config = function()
      require('mini.pairs').setup()
    end
  },

  -- navigation buffer
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("pencilbox.plugins.configs._harpoon")
    end
  },

  -- neogit
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",  -- required
      "sindrets/diffview.nvim", -- optional - Diff integration

      -- Only one of these is needed, not both.
      "nvim-telescope/telescope.nvim", -- optional
      "ibhagwan/fzf-lua",              -- optional
    },
    config = true
  },

  -- gitsigns
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require('pencilbox.plugins.configs._gitsigns').setup()
    end
  },

  -- lsp-fidget
  {
    "j-hui/fidget.nvim",
    config = function()
      require("fidget").setup {}
    end
  },

  -- lspconfig
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      require("pencilbox.plugins.configs._lspconfig").setup()
    end
  },

  -- cmp
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",                -- LSP source for nvim-cmp
      "hrsh7th/cmp-buffer",                  -- LSP source for nvim-cmp
      "hrsh7th/cmp-path",                    -- LSP source for nvim-cmp
      "hrsh7th/cmp-cmdline",                 -- LSP source for nvim-cmp
      "hrsh7th/cmp-nvim-lsp-signature-help", -- LSP source for nvim-cmp
      "L3MON4D3/LuaSnip",                    -- Snippet Engine
      "saadparwaiz1/cmp_luasnip"             -- Snippet source for nvim-cmp
    },
    config = function()
      require("pencilbox.plugins.configs._cmp").setup()
    end
  }
}

return plugins
