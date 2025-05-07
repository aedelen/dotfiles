-- vim config
-- Enable line numbers
vim.cmd("set nu")
-- Enable relative line numbers
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
