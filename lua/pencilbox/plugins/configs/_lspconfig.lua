local M = {}
local map = vim.keymap.set

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

M.setup = function()
  require("mason").setup()
  require("mason-lspconfig").setup({
    ensure_installed = {
      "lua_ls",
      "rust_analyzer",
      "clangd",
      "jsonls",
      "glsl_analyzer"
    }
  })

  local lspconfig = require("lspconfig")

  -- lua
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

  -- rust
  lspconfig.rust_analyzer.setup {
    on_attach = M.on_attach,
    capabilities = M.capabilities,     -- require('cmp_nvim_lsp').default_capabilities(),
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

  -- rust
  lspconfig.clangd.setup {
    on_attach = M.on_attach,
    capabilities = M.capabilities,     -- require('cmp_nvim_lsp').default_capabilities(),
    on_init = M.on_init,
  }

  -- sourcekit
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

  lspconfig.glsl_analyzer.setup {
    on_attach = M.on_attach,
    capabilities = M.capabilities,
    on_init = M.on_init,
  }
end

return M
