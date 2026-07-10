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

-- Reload files modified externally (e.g., by Claude Code)
keymap.set("n", "<leader>rl", "<cmd>checktime<CR>", { desc = "Reload file from disk" })

-- Show quickfixes / code actions for the error under the cursor
vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "LSP Code Action" })

-- Open a window at the bottom showing all errors/warnings
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open Diagnostic Quickfix List" })

-- Jump to the next error/warning
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Next Diagnostic" })

-- Jump to the previous error/warning
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous Diagnostic" })

-- Show a floating cheatsheet with the most important keymaps
vim.keymap.set("n", "<leader>h", function()
  local lines = {
    " Search (mini.pick)",
    "   <Space>sf   Find files",
    "   <Space>sg   Live grep",
    "   <Space>sb   Find buffers",
    "   <Space>sc   Git hunks in buffer (unstaged)",
    "   <Space>sC   Git hunks in buffer (staged)",
    "",
    " Git",
    "   <Space>gs   Git status (changed files)",
    "   <Space>gd   Toggle git diff overlay",
    "   <Space>gb   Toggle inline git blame",
    "   <Space>go   Open blame commit in browser",
    "",
    " LSP (when a server is attached)",
    "   gd          Go to definition",
    "   gr          Find all references",
    "   gi          Go to implementation",
    "   gy          Go to type definition",
    "   K           Hover documentation",
    "   <Space>rn   Rename symbol",
    "   <Space>ca   Code action",
    "   <Space>th   Toggle inlay hints",
    "",
    " Diagnostics",
    "   <Space>q    Diagnostic quickfix list",
    "   ]d / [d     Next / previous diagnostic",
    "",
    " Files & editing",
    "   <Space>e    File explorer (mini.files)",
    "   <Space>cf   Format file",
    "   <Space>rl   Reload file from disk",
    "   <C-s>       Save file",
    "   <C-hjkl>    Move between windows",
    "",
    " (q or <Esc> to close)",
  }

  local width = 0
  for _, line in ipairs(lines) do
    width = math.max(width, vim.fn.strdisplaywidth(line))
  end

  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
  vim.bo[buf].modifiable = false
  vim.bo[buf].bufhidden = "wipe"

  local win = vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    width = width + 2,
    height = #lines,
    col = math.floor((vim.o.columns - width - 2) / 2),
    row = math.floor((vim.o.lines - #lines) / 2),
    style = "minimal",
    border = "rounded",
    title = " Keymaps ",
    title_pos = "center",
  })

  local close = function()
    if vim.api.nvim_win_is_valid(win) then
      vim.api.nvim_win_close(win, true)
    end
  end
  vim.keymap.set("n", "q", close, { buffer = buf })
  vim.keymap.set("n", "<Esc>", close, { buffer = buf })
end, { desc = "Show keymap cheatsheet" })

-- LSP keymaps (VS Code equivalents), enabled per-buffer whenever a language
-- server attaches (TypeScript, LaTeX, ...)
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("user-lsp-keymaps", { clear = true }),
  callback = function(event)
    local map = function(keys, fn, desc)
      vim.keymap.set("n", keys, fn, { buffer = event.buf, desc = desc })
    end

    map("gd", vim.lsp.buf.definition, "Go to Definition")          -- VS Code: F12
    map("gD", vim.lsp.buf.declaration, "Go to Declaration")
    map("gr", vim.lsp.buf.references, "Find All References")       -- VS Code: Shift+F12
    map("gi", vim.lsp.buf.implementation, "Go to Implementation")
    map("gy", vim.lsp.buf.type_definition, "Go to Type Definition")
    map("<leader>rn", vim.lsp.buf.rename, "Rename Symbol")         -- VS Code: F2
    map("K", vim.lsp.buf.hover, "Hover Documentation")

    -- Toggle inlay hints (parameter names / return types)
    map("<leader>th", function()
      vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
    end, "Toggle Inlay Hints")
  end,
})
