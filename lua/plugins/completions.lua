-- nvim-cmp: completion engine for neovim. It will show the completion list but still requires sources
-- luasnip: snippet engine for neovim, supplying sources for nvim-comp but expand the snippet is done by cmp_luasnip
-- friendly_snippets: vscode snippets sources
-- cmp_luasnip: completion engine for luasnip, when you select a snippet, cmp_luasnip will expand that
--
-- cmp-nvim-lsp: nvim-cmp source for neovim's built-in language server client.
--    it reaches out to any lsp your buffer attached to, and ask for a list of completions recommendation
--    and then cmp-nvim-lsp will expand that

return {
  {
    "hrsh7th/nvim-cmp", -- completion engine for neovim
    config = function()
      local cmp = require("cmp")
      require("luasnip.loaders.from_vscode").lazy_load()
      cmp.setup({
        snippet = {
          expand = function(args)
            require('luasnip').lsp_expand(args.body)
          end,
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
        }),
        sources = cmp.config.sources(
          {
            { name = "luasnip" },
            { name = "nvim_lsp" },
          },
          {
            { name = "buffer" },
          }
        ),
      })
    end
  },
  {
     "hrsh7th/cmp-nvim-lsp"
  },
  {
    "L3MON4D3/LuaSnip",
    dependencies = {
      "saadparwaiz1/cmp_luasnip", -- completion engine for Luasnip
      "rafamadriz/friendly-snippets", -- sources from vscode
    },
  },
  {
     "hrsh7th/cmp-buffer"
  },
  {
     "hrsh7th/cmp-path",
  },
  {
     "hrsh7th/cmp-cmdline"
  },
}
