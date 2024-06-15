local M = {}
local map = vim.keymap.set

-- export on_attach & capabilities
M.on_attach = function(_, bufnr)
  --  vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })

  local function opts(desc)
    return { buffer = bufnr, desc = "LSP " .. desc }
  end

  map("n", "gD", vim.lsp.buf.declaration, opts "Go to declaration")
  map("n", "gd", vim.lsp.buf.definition, opts "Go to definition")
  map("n", "gi", vim.lsp.buf.implementation, opts "Go to implementation")
  map("n", "<leader>sh", vim.lsp.buf.signature_help, opts "Show signature help")
  map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts "Add workspace folder")
  map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts "Remove workspace folder")
  map("n", "K", vim.lsp.buf.hover, opts "Hover")
  map("n", "<leader>d", vim.diagnostic.open_float, opts "Show Line Diagnostics")
  map("n", "<leader>D", vim.lsp.buf.type_definition, opts "Go to type definition")
  map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts "Code action")
  map("n", "gr", vim.lsp.buf.references, opts "Show references")
end

-- disable semanticTokens
M.on_init = function(client, _)
  if client.supports_method "textDocument/semanticTokens" then
    client.server_capabilities.semanticTokensProvider = nil
  end
end

M.capabilities = vim.lsp.protocol.make_client_capabilities()
-- M.cmp_capabilities = require('cmp_nvim_lsp').default_capabilities()

M.capabilities.textDocument.completion.completionItem = {
  documentationFormat = { "markdown", "plaintext" },
  snippetSupport = true,
  preselectSupport = true,
  insertReplaceSupport = true,
  labelDetailsSupport = true,
  deprecatedSupport = true,
  commitCharactersSupport = true,
  tagSupport = { valueSet = { 1 } },
  resolveSupport = {
    properties = {
      "documentation",
      "detail",
      "additionalTextEdits",
    },
  },
}

local function lspSymbol(name, icon)
  local hl = "DiagnosticSign" .. name
  vim.fn.sign_define(hl, { text = icon, numhl = hl, texthl = hl })
end

lspSymbol("Error", "󰅙")
lspSymbol("Info", "󰋼")
lspSymbol("Hint", "󰌵")
lspSymbol("Warn", "")

return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      -- catppuccin-latte, catppuccin-frappe, catppuccin-macchiato, catppuccin-mocha
      vim.cmd("colorscheme catppuccin-frappe")
    end
  },

  {
    'nvim-treesitter/nvim-treesitter',
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "rust", "swift" },
      })
    end
  },

  {
    'nvim-telescope/telescope.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' }
  },

  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require('gitsigns').setup {
        signs = {
          add = { text = "▎" },
          change = { text = "▎" },
          delete = { text = "" },
          topdelete = { text = "" },
          changedelete = { text = "▎" },
          untracked = { text = "▎" },
        },
        on_attach = function(buffer)
          local gs = package.loaded.gitsigns

          local function map(mode, l, r, desc)
            vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
          end

          -- stylua: ignore start
          map("n", "]h", function() gs.nav_hunk("next") end, "Next Hunk")
          map("n", "[h", function() gs.nav_hunk("prev") end, "Prev Hunk")
          map("n", "]H", function() gs.nav_hunk("last") end, "Last Hunk")
          map("n", "[H", function() gs.nav_hunk("first") end, "First Hunk")
        end,
      }
    end
  },

  {
    'stevearc/conform.nvim',
    config = function()
      require("conform").setup({
        formatters_by_ft = {
          lua = { "stylua" },
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

  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("harpoon"):setup({})
    end
  },

  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls",
          "rust_analyzer",
          "clangd",
          "jsonls",
        }
      })
      local lspconfig = require("lspconfig")
      lspconfig.lua_ls.setup {
        on_attach = M.on_attach,
        capabilities = M.capabilities,
        on_init = M.on_init,
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" }
            }
          }
        }
      }
      lspconfig.rust_analyzer.setup {
        on_attach = M.on_attach,
        capabilities = M.capabilities, -- require('cmp_nvim_lsp').default_capabilities(),
        on_init = M.on_init,
        settings = {
          ["rust-analyzer"] = {
            imports = {
              granularity = {
                group = "module",
              },
              prefix = "self"
            },
            cargo = {
              buildScripts = {
                enable = true
              }
            },
            procMacro = {
              enable = true
            }
          }
        }
      }
      lspconfig.clangd.setup {}
      lspconfig.jsonls.setup {}
      lspconfig.tsserver.setup {
        on_attach = M.on_attach,
        on_init = M.on_init,
        capabilities = M.capabilities,
      }
      lspconfig.sourcekit.setup {
        cmd = { "sourcekit-lsp" },
        filetypes = { "swift", "objective-c" },
        root_dir = lspconfig.util.root_pattern(
          "buildServer.json",
          "*.xcodeproj",
          "*.xcworkspace",
          ".git",
          "compile_commands.json",
          "Package.swift"
        )
      }
    end
  },

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
      local cmp = require("cmp")
      cmp.setup {
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        mapping = {
          ["<C-p>"] = cmp.mapping.select_prev_item(),
          ["<C-n>"] = cmp.mapping.select_next_item(),
          ["<C-d>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.close(),

          ["<CR>"] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Insert,
            select = true,
          },

          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif require("luasnip").expand_or_jumpable() then
              vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true), "")
            else
              fallback()
            end
          end, { "i", "s" }),

          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif require("luasnip").jumpable(-1) then
              vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-jump-prev", true, true, true), "")
            else
              fallback()
            end
          end, { "i", "s" }),
        },

        sources = {
          { name = 'nvim_lsp' },
          { name = 'buffer' },
          { name = 'path' },
          { name = 'nvim_lsp_signature_help' }
        }
      }
    end
  }
}
