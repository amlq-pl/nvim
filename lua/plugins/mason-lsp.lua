-- ~/.config/nvim/lua/plugins/mason-lsp.lua
return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig", 
  },
  config = function()
    -- 1. Initialize Mason to download servers
    require("mason").setup()
    
    require("mason-lspconfig").setup({
      ensure_installed = { "texlab" }, 
    })

    -- 2. Configure TexLab using the new Neovim 0.11+ API
    vim.lsp.config("texlab", {
      settings = {
        texlab = {
          build = { onSave = true },
          forwardSearch = {
            executable = "/Applications/Skim.app/Contents/SharedSupport/displayline",
            args = { "-g", "%l", "%p", "%f" },
          },
        },
      }
    })

    -- 3. Enable the server
    vim.lsp.enable("texlab")
  end,
}
