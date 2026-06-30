return {
  "echasnovski/mini.files",
  version = "*",
  config = function()
    require("mini.files").setup()
    
    -- Open file explorer with <leader>e
    vim.keymap.set("n", "<leader>e", function()
      require("mini.files").open(vim.api.nvim_buf_get_name(0))
    end, { desc = "Open mini.files" })
  end,
}
