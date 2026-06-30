return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  -- CRITICAL: Delay loading until Neovim is fully booted and you open a file
  event = { "BufReadPost", "BufNewFile" }, 
  config = function()
    -- Use a protected call. If Treesitter isn't downloaded yet, it won't crash Neovim.
    local status_ok, configs = pcall(require, "nvim-treesitter.configs")
    if not status_ok then
      return
    end

    configs.setup({
      ensure_installed = { "lua", "vim", "vimdoc", "python", "javascript", "typescript", "html", "css" },
      highlight = {
        enable = true,
        disable = { "latex", "tex" }, 
      },
      indent = { enable = true },
    })
  end,
}
