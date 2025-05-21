vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- [[ Basic options ]]
vim.opt.number = true

vim.opt.mouse = "a"

vim.opt.showmode = false

--vim.opt.clipboard = "unnamedplus"

vim.opt.breakindent = true

vim.opt.undofile = true

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.signcolumn = "yes"

vim.opt.updatetime = 250

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

vim.opt.inccommand = "split"

vim.opt.cursorline = true

vim.opt.scrolloff = 10

vim.opt.confirm = true

vim.opt.expandtab = true
vim.opt.tabstop = 8
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4

vim.opt.completeopt = "menuone,noselect,popup"

-- [[ Basic Keymaps ]]
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

vim.keymap.set("v", "<leader>y", '"+y', { desc = "Copy to clipboard" })

vim.keymap.set("n", "<leader>t", ":split term://bash<CR>", { desc = "Open terminal" })
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
vim.keymap.set("t", "<C-h>", "<C-\\><C-n><C-w><C-h>", { desc = "Exit terminal mode to the left window" })
vim.keymap.set("t", "<C-l>", "<C-\\><C-n><C-w><C-l>", { desc = "Exit terminal mode to the right window" })
vim.keymap.set("t", "<C-j>", "<C-\\><C-n><C-w><C-j>", { desc = "Exit terminal mode to the lower window" })
vim.keymap.set("t", "<C-k>", "<C-\\><C-n><C-w><C-k>", { desc = "Exit terminal mode to the upper window" })

-- [[ Install `lazy.nvim` plugin manager ]]
require("config.lazy")
