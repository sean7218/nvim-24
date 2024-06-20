local M = {}

M.setup = function()
  require('gitsigns').setup {
    signs = {
      add = { text = "▎" },
      change = { text = "▎" },
      delete = { text = "" },
      topdelete = { text = "" },
      changedelete = { text = "▎" },
      untracked = { text = "▎" },
    },
    on_attach = function(buffer)
      local gs = package.loaded.gitsigns

      local function map(mode, l, r, desc)
        vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
      end

      -- stylua: ignore start
      map("n", "]h", function() gs.nav_hunk("next") end, "Next Hunk")
      map("n", "[h", function() gs.nav_hunk("prev") end, "Prev Hunk")
      map("n", "]H", function() gs.nav_hunk("last") end, "Last Hunk")
      map("n", "[H", function() gs.nav_hunk("first") end, "First Hunk")
      map("n", "<leader>hp", function() gs.preview_hunk() end, "preview hunk")
      map("n", "<leader>hs", function() gs.state_hunk() end, "stage hunk")
      map("n", "<leader>hu", function() gs.undo_state_hunk() end, "undo stage hunk")
      map("n", "<leader>hr", function() gs.reset_hunk() end, "reset hunk")
    end,
  }
end

return M
