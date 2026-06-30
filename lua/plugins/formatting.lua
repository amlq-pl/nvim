return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    require("conform").setup({
      formatters_by_ft = {
        tex = { "latexindent" },
        -- In the future, add: python = { "black" }, javascript = { "prettier" }, etc.
      },
      -- Uncomment this if you want it to format every time you save:
      format_on_save = { timeout_ms = 1000, lsp_fallback = true },
      formatters = {
        latexindent = {
          prepend_args = { "-m" },
        },
      },
    })

    -- Keyboard shortcut: Press <Space>cf to Format the file
    vim.keymap.set({ "n", "v" }, "<leader>cf", function()
      require("conform").format({ lsp_fallback = true, timeout_ms = 1000 })
    end, { desc = "Format file" })
  end,
}
