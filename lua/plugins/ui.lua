return {
  { "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 500
    end,
  },
  -- Required by neovim-qt:
  { "equalsraf/neovim-gui-shim" },

  { "nvim-lualine/lualine.nvim",
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {},
  },
  { 'akinsho/bufferline.nvim',
    version = "*",
    dependencies = 'nvim-tree/nvim-web-devicons',
    opts = {
      options = {
        separator_style = "slant",
        numbers = function(o)
          return string.format('%s', o.ordinal)
        end
      }
    },
  },
}
