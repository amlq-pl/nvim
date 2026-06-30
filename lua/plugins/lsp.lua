return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
  },
  config = function()
    -- 1. Start Mason (the installer)
    require("mason").setup()
    
    -- 2. Tell Mason to make sure TexLab is always installed
    require("mason-lspconfig").setup({
      ensure_installed = { "texlab" },
    })

    -- 3. Configure TexLab using the modern Neovim 0.11 API
    vim.lsp.config("texlab", {
      settings = {
        texlab = {
          build = { onSave = true },
          forwardSearch = {
            -- The hidden Skim utility for jumping to lines
            executable = "/Applications/Skim.app/Contents/SharedSupport/displayline",
            args = { "-g", "%l", "%p", "%f" },
          },
        },
      }
    })

    -- 4. Enable it!
    vim.lsp.enable("texlab")
  end,
}
