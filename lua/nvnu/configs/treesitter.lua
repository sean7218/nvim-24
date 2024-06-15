return {
  ensure_installed = {
    "c",
    "cpp",
    "swift",
    "rust",
    "typescript",
    "javascript",
    "json",
    "yaml",
    "lua",
    "vim",
    "vimdoc",
    "query",
    "html",
    "markdown",
    "markdown_inline"
  },
  sync_install = false,
  highlight = { enable = true },
  indent = { enable = true },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = '<CR>',
      scope_incremental = '<CR>',
      node_incremental = '<C-S-LEFT>',
      node_decremental = '<C-S-RIGHT>',
    },
  },
}
