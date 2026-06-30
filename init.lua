require("config.options")
require("config.keymaps")

-- 1. Bootstrap Lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", 
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- 2. Tell Lazy to load all plugin files inside lua/plugins/
require("lazy").setup({
  spec = { 
    { import = "plugins" } 
  },
  checker = { 
      enabled = true,
      notify = false,
  },
})
