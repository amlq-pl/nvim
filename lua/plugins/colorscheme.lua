-- ~/.config/nvim/lua/plugins/colorscheme.lua
return {
  { "folke/tokyonight.nvim", lazy = true },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd.colorscheme("catppuccin-mocha")
    end,
  },
}
