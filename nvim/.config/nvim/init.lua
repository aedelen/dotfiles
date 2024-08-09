-- vim config
vim.cmd("set nu")
vim.cmd("set rnu")

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Lazy Nvim
require("config.lazy")

require("vim-options")

-- Healthchecks from Nvim Kickstart
require("health")
