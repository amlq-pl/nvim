-- ~/.config/nvim/lua/config/keymaps.lua

-- Set Space as the leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local keymap = vim.keymap

-- Clear search highlights when pressing <Esc>
keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlights" })

-- Better window navigation (use Ctrl + h/j/k/l to move between split panes)
keymap.set("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
keymap.set("n", "<C-j>", "<C-w>j", { desc = "Go to lower window" })
keymap.set("n", "<C-k>", "<C-w>k", { desc = "Go to upper window" })
keymap.set("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })

-- Easily save the current file using Ctrl+s
keymap.set({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save file" })

-- Show quickfixes / code actions for the error under the cursor
vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "LSP Code Action" })

-- Open a window at the bottom showing all errors/warnings
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open Diagnostic Quickfix List" })

-- Jump to the next error/warning
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Next Diagnostic" })

-- Jump to the previous error/warning
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous Diagnostic" })
