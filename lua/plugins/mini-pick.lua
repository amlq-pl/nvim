return {
  "echasnovski/mini.pick",
  version = "*", -- Use the latest stable release
  dependencies = {
    "echasnovski/mini.icons",
    "echasnovski/mini.nvim", -- provides mini.extra (git hunks picker)
  },
  config = function()
    local pick = require("mini.pick")

    -- Setup with default mappings
    pick.setup()

    -- Extra pickers (git hunks, ...) from the mini.nvim bundle
    require("mini.extra").setup()

    -- Define your keymaps
    vim.keymap.set("n", "<leader>sf", pick.builtin.files, { desc = "Find files" })
    vim.keymap.set("n", "<leader>sg", pick.builtin.grep_live, { desc = "Live grep" })
    vim.keymap.set("n", "<leader>sb", pick.builtin.buffers, { desc = "Find buffers" })
    -- Git hunks in current buffer. n_context = 0 keeps every change as its
    -- own entry (default merges edits within 3 context lines into one hunk).
    -- Note: diffs the file on disk, so save first; staged hunks are on <leader>sC.
    vim.keymap.set("n", "<leader>sc", function()
      MiniExtra.pickers.git_hunks({ path = vim.api.nvim_buf_get_name(0), n_context = 0 })
    end, { desc = "Git hunks in buffer (unstaged)" })
    vim.keymap.set("n", "<leader>sC", function()
      MiniExtra.pickers.git_hunks({ path = vim.api.nvim_buf_get_name(0), n_context = 0, scope = "staged" })
    end, { desc = "Git hunks in buffer (staged)" })

    -- Git status: one list of all modified/added/deleted/untracked files.
    -- Lines look like "M  lua/init.lua" or "?? new.txt"; choosing opens the file.
    vim.keymap.set("n", "<leader>gs", function()
      pick.builtin.cli({ command = { "git", "status", "--short" } }, {
        source = {
          name = "Git status",
          choose = function(item)
            local path = item:sub(4)                -- strip the "XY " status prefix
            path = path:match("-> (.*)$") or path   -- renames show as "old -> new"
            vim.schedule(function()
              vim.cmd("edit " .. vim.fn.fnameescape(path))
            end)
          end,
        },
      })
    end, { desc = "Git status (changed files)" })
  end,
}
