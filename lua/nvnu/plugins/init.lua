return {
  -- theme
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = function()
      return require "nvnu.configs.catppuccin"
    end,
    config = function(_, opts)
      require("catppuccin").setup(opts)
      vim.cmd("colorscheme catppuccin")
    end
  },

  -- treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPost", "BufNewFile" },
    cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
    build = ":TSUpdate",
    opts = function()
      return require "nvnu.configs.treesitter"
    end,
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
  },

  -- telescope
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = function()
      return require("nvnu.configs.telescope")
    end,
    config = function(_, opts)
      require('telescope').setup(opts)
    end
  },

  -- formatting
  {
    'stevearc/conform.nvim',
    opts = {},
  },

  -- comment code
  {
    'numToStr/Comment.nvim',
    opts = {
      -- add any options here
    }
  },

  -- lsp
  {
    "williamboman/mason.nvim",
    opts = function()
      return require "nvnu.configs.mason"
    end,
    config = function(_, opts)
      require("mason").setup(opts)
    end,
  },

  {
    "williamboman/mason-lspconfig.nvim",
    opts = function()
      return require("mason")
    end,
    config = function(_, opts)
      require("mason-lspconfig").setup({
        ensure_installed = opts.ensure_installed
      })
    end,
  },

  {
    "neovim/nvim-lspconfig",
    lazy = false,
    config = function()
      require("nvnu.configs.lspconfig").defaults()
      require("nvnu.configs.lspservers")
    end,
  },

  -- whichkey
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    opts = {}
  },

  -- indenting
  { "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} },

  -- neogit
  --  {
  --    'lewis6991/gitsigns.nvim',
  --    config = function()
  --      require('gitsigns').setup()
  --    end,
  --  },
  --
  --  {
  --    "NeogitOrg/neogit",
  --    dependencies = {
  --      "nvim-lua/plenary.nvim",         -- required
  --      "sindrets/diffview.nvim",        -- optional - Diff integration
  --
  --      -- Only one of these is needed, not both.
  --      "nvim-telescope/telescope.nvim", -- optional
  --      -- "ibhagwan/fzf-lua",              -- optional
  --    },
  --    config = true
  --  }

  -- tree
  --  {
  --    "nvim-neo-tree/neo-tree.nvim",
  --    branch = "v3.x",
  --    dependencies = {
  --      "nvim-lua/plenary.nvim",
  --      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
  --      "MunifTanjim/nui.nvim",
  --      -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
  --    }
  --  },



  --
  --   -- null-lsp stuff
  --   {
  --     "jose-elias-alvarez/null-ls.nvim",
  --   },
  --
  --   {
  --     "nvimtools/none-ls.nvim",
  --     config = function()
  --       local null_ls = require("null-ls")
  --       null_ls.setup({
  --         sources = {
  --           null_ls.builtins.formatting.stylua,
  --           null_ls.builtins.formatting.swiftlint,
  --           null_ls.builtins.diagnostics.swiftlint,
  --         },
  --       })
  --
  --       vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
  --     end,
  --   },


  -- load luasnips + cmp related in insert mode only
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      {
        -- snippet plugin
        "L3MON4D3/LuaSnip",
        dependencies = "rafamadriz/friendly-snippets",
        opts = { history = true, updateevents = "TextChanged,TextChangedI" },
        config = function(_, opts)
          -- require("luasnip").config.set_config(opts)
          -- require "nvnu.configs.luasnip"
        end,
      },

      -- autopairing of (){}[] etc
      {
        "windwp/nvim-autopairs",
        opts = {
          fast_wrap = {},
          disable_filetype = { "TelescopePrompt", "vim" },
        },
        config = function(_, opts)
          require("nvim-autopairs").setup(opts)
          -- setup cmp for autopairs
          local cmp_autopairs = require "nvim-autopairs.completion.cmp"
          require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
        end,
      },

      -- cmp sources plugins
      {
        "saadparwaiz1/cmp_luasnip",
        "hrsh7th/cmp-nvim-lua",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
      },

    },    -- end of dependencies

    opts = function()
      return require "nvnu.configs.cmp"
    end,

    config = function(_, opts)
      require("cmp").setup(opts)
    end,

  },    -- end of cmp

}
