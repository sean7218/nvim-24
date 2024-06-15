
vim.g.mapleader = " "

local opt = vim.opt

opt.relativenumber = true -- Relative line numbers

opt.expandtab = true -- Use spaces instead of tabs
opt.shiftwidth = 2 -- Size of an indent
opt.tabstop = 2 -- Number of spaces tabs count for
opt.smartindent = true -- Insert indents automatically

opt.termguicolors = true -- True color support

opt.wrap = false -- Disable line wrap

opt.grepprg = "rg --vimgrep"

