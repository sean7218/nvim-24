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

-- nvnu module
-- local plugins = require("init_nvnu")
-- require("lazy").setup(plugins, {})

-- pencilbox module
local plugins = require("init_pencilbox")
require("lazy").setup(plugins, {})
