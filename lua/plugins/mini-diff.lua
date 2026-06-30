return {
  "echasnovski/mini.diff",
  version = "*",
  config = function()
    require("mini.diff").setup({
      view = { style = "sign" }, -- Shows +/- in the sidebar
    })
    
    -- Shortcut to view the diff in a separate split
    vim.keymap.set("n", "<leader>gd", "<cmd>lua MiniDiff.toggle_overlay()<CR>", { desc = "Toggle Git Diff" })
  end,
}
