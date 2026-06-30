return {
  "lervag/vimtex",
  lazy = false, -- VimTeX specifically requests not to be lazy-loaded
  init = function()
    -- 1. Detect the operating system
    -- (Uses vim.uv for Neovim 0.10+, and falls back to vim.loop for older versions)
    local os_name = (vim.uv or vim.loop).os_uname().sysname

    -- 2. Apply OS-specific viewer settings
    if os_name == "Darwin" then
      -- macOS Settings
      vim.g.vimtex_view_method = "skim"
      vim.g.vimtex_view_skim_sync = 1
      vim.g.vimtex_view_skim_activate = 1
    elseif os_name == "Linux" then
      -- Ubuntu / Linux Settings
      vim.g.vimtex_view_method = "zathura"
    end
    
    -- 3. Shared settings (applies to both OS)
    vim.g.vimtex_compiler_method = "latexmk"
    vim.g.vimtex_syntax_enabled = 1
    vim.g.vimtex_quickfix_mode = 0
  end,
}
