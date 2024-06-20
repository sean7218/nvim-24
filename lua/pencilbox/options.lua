
vim.g.mapleader = " "

local opt = vim.opt

opt.number = true -- show numbers
opt.relativenumber = true -- Relative line numbers
opt.numberwidth = 2 -- number gutter width
opt.ruler = true

opt.expandtab = true -- Use spaces instead of tabs
opt.shiftwidth = 2 -- Size of an indent
opt.tabstop = 2 -- Number of spaces tabs count for
opt.smartindent = true -- Insert indents automatically

opt.termguicolors = true -- True color support

opt.wrap = false -- Disable line wrap

opt.grepprg = "rg --vimgrep"

vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"

vim.opt.foldlevel = 99 -- min fold level will be closed by default
vim.opt.foldlevelstart = 8 -- fold level when opening a buffer
