return {
  "lervag/vimtex",
  lazy = false, -- VimTeX specifically requests not to be lazy-loaded
  init = function()
    -- Tell VimTeX to use Skim for Mac
    vim.g.vimtex_view_method = "skim"
    
    -- Keep focus in Neovim when Skim updates
    vim.g.vimtex_view_skim_sync = 1
    vim.g.vimtex_view_skim_activate = 1
    
    -- Use latexmk for continuous compilation
    vim.g.vimtex_compiler_method = "latexmk"
    
    -- Prevent syntax highlighting lag on M1 Macs
    vim.g.vimtex_syntax_enabled = 1
    
    -- Don't open the quickfix window automatically on every tiny warning
    vim.g.vimtex_quickfix_mode = 0
  end,
}
