return {
  { "nvim-telescope/telescope.nvim",
    version = "0.1.x",
    dependencies = { "nvim-lua/plenary.nvim" },
    lazy = false,
    keys = {
      { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find files" },
      { "<leader>fF", "<cmd>Telescope git_files<cr>", desc = "Find files" },
      { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live grep" },
      { "<leader>fs", "<cmd>Telescope grep_string<cr>", desc = "Find string" },
      { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Find string" },
      { "<leader>fr", "<cmd>Telescope lsp_references<cr>", desc = "LSP references" },
      { "<leader>fc", "<cmd>Telescope lsp_incoming_calls<cr>", desc = "LSP incoming calls" },
    }
  }
}
