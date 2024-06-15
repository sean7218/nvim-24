
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

