
local on_attach = require("nvnu.configs.lspconfig").on_attach
local on_init = require("nvnu.configs.lspconfig").on_init
local capabilities = require("nvnu.configs.lspconfig").capabilities
local lspconfig = require "lspconfig"
local servers = {
  "html",
  "cssls",
  "lua_ls",
  "clangd",
  "rust_analyzer"
}

-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,
  }
end

-- typescript
lspconfig.tsserver.setup {
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
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
