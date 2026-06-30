return {
  "echasnovski/mini.pick",
  version = "*", -- Use the latest stable release
  dependencies = { "echasnovski/mini.icons" },
  config = function()
    local pick = require("mini.pick")
    
    -- Setup with default mappings
    pick.setup()

    -- Define your keymaps
    vim.keymap.set("n", "<leader>sf", pick.builtin.files, { desc = "Find files" })
    vim.keymap.set("n", "<leader>sg", pick.builtin.grep_live, { desc = "Live grep" })
    vim.keymap.set("n", "<leader>sb", pick.builtin.buffers, { desc = "Find buffers" })
  end,
}
