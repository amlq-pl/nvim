return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
  },
  config = function()
    require("mason").setup()
    require("mason-lspconfig").setup({
      ensure_installed = { "texlab" },
    })

    -- Detect the OS for LSP configuration
    local os_name = (vim.uv or vim.loop).os_uname().sysname
    local forward_search_config = {}

    if os_name == "Darwin" then
      -- Mac Skim arguments
      forward_search_config = {
        executable = "/Applications/Skim.app/Contents/SharedSupport/displayline",
        args = { "-g", "%l", "%p", "%f" },
      }
    elseif os_name == "Linux" then
      -- Ubuntu Zathura arguments
      forward_search_config = {
        executable = "zathura",
        args = { "--synctex-forward", "%l:1:%f", "%p" },
      }
    end

    -- Configure TexLab dynamically
    vim.lsp.config("texlab", {
      settings = {
        texlab = {
          build = { onSave = true },
          forwardSearch = forward_search_config,
        },
      }
    })

    vim.lsp.enable("texlab")
  end,
}
