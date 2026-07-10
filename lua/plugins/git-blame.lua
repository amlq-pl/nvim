return {
  "f-person/git-blame.nvim",
  event = "BufReadPost",
  config = function()
    require("gitblame").setup({
      date_format = "%r", -- relative dates: "3 months ago"
      message_template = "  <author> • <date> • <summary>",
      message_when_not_committed = "  not committed yet",
    })

    -- Toggle the inline blame text on/off
    vim.keymap.set("n", "<leader>gb", "<cmd>GitBlameToggle<CR>", { desc = "Toggle inline git blame" })

    -- Open the blamed commit on GitHub/GitLab in the browser
    vim.keymap.set("n", "<leader>go", "<cmd>GitBlameOpenCommitURL<CR>", { desc = "Open blame commit in browser" })
  end,
}
