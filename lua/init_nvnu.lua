require("nvnu.options")
require("nvnu.mappings")
require("nvnu.autocmds")

local nvconfig = require("nvnu.nvconfig").ui
vim.o.statusline = "%!v:lua.require('nvnu.stl." .. nvconfig.statusline.theme .. "')()"

local plugins = require("nvnu.plugins")
return plugins
