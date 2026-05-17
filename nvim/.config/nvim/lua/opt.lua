-- use four spaces for tabs as God intended.
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4

-- no wrap!
vim.wo.wrap = false

-- set relative line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- allow copying to OS clipboard
vim.opt.clipboard = "unnamedplus"

vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- show number of errors when available
vim.opt.signcolumn = "number"

-- how long until swap file is written
vim.opt.updatetime = 250

vim.opt.splitright = true
vim.opt.splitbelow = true

-- show find/replace operations in a split window.
vim.opt.inccommand = "split"

-- TODO: do I want this?
-- vim.opt.cursorline = true
vim.opt.scrolloff = 5
