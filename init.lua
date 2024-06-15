-- set global leader
vim.g.mapleader = " "

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system {
    "git",
    "clone",
    "--filter=blob:none",
    repo,
    "--branch=stable",
    lazypath
  }
end

vim.opt.rtp:prepend(lazypath)

local plugins = require("nvnu.plugins")
require("lazy").setup(plugins, {})

require "nvnu.autocmds"
vim.schedule(function()
  require "nvnu.mappings"
  require "nvnu.options"
end)

local nvconfig = require("nvconfig").ui
vim.o.statusline = "%!v:lua.require('nvnu.stl." .. nvconfig.statusline.theme .. "')()"
