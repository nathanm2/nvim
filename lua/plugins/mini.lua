return {
  {
    'echasnovski/mini.nvim',
    version = '*',
    config = function()

      local set_keymap = vim.api.nvim_set_keymap

      -- Mini.pick
      --
      -- For more help, see: MiniPick-overview, MiniPick-source, MiniPick-actions, MiniPick-examples,
      -- MiniPick.builtin.
      require("mini.pick").setup()
      set_keymap("n", "<C-p>", "<cmd>Pick files<cr>", {desc = "Find file (rg)"})
      set_keymap("n", "<C-g>", "<cmd>Pick grep_live<cr>", {desc = "Find text (rg)"})
      set_keymap("n", "<C-b>", "<cmd>Pick buffers<cr>", {desc = "Find buffer (rg)"})

      require("mini.clue").setup({

        -- Register triggers to start the query process:
        triggers = {
          -- Leader triggers
          { mode = "n", keys = "<Leader>" },
          { mode = "x", keys = "<Leader>" },
        },

        -- Add descriptions.
        clues = {
          { mode = "n", keys = "<Leader>u", desc = "+UI"},
          { mode = "n", keys = "<Leader>f", desc = "+Format"},
        },
      })

    end,
  },
}
