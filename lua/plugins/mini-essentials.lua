return {
  "echasnovski/mini.nvim",
  version = "*",
  config = function()
    require("mini.pairs").setup()
    require("mini.surround").setup()
    -- require("mini.ai").setup()
    require("mini.comment").setup()
    -- require("mini.operators").setup()
  end,
}
