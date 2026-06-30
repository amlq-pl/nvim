-- ~/.config/nvim/lua/config/options.lua

local opt = vim.opt

-- Line numbers
opt.number = true         -- Show absolute line number on the current line
opt.relativenumber = true -- Show relative line numbers on other lines (great for jumping around)

-- Sync with Mac clipboard
opt.clipboard = "unnamedplus"

opt.shiftwidth = 4
opt.tabstop = 4
opt.expandtab = true      -- Convert tabs to spaces
opt.smartindent = true

-- Search settings
opt.ignorecase = true     -- Ignore case when searching
opt.smartcase = true      -- Unless you type a capital letter

-- UI tweaks
opt.termguicolors = true  -- Enable 24-bit RGB colors
opt.signcolumn = "yes"    -- Always show the sign column (prevents text shifting when errors pop up)
opt.wrap = false          -- Don't wrap long lines automatically
opt.mouse = "a"           -- Enable mouse support in all modes
