-- vim.loader.enable()

local cmd = vim.cmd
local opt = vim.o

-- Enable line numbers
opt.number = true

-- Enable relative line numbers
opt.relativenumber = true

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

