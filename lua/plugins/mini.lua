return {
  {
    'echasnovski/mini.nvim',
    version = '*',
    config = function()
      require("mini.pick").setup()
    end,
  },
}
