-- A Minimimal Neovim Configuration

-- Source our common vim/nvim config.
--
-- For config options that you'd like to keep common between vim/nvim:
local config_dir = vim.fn.stdpath("config")
local vimrc = config_dir .. "/vimrc-common.vim"
vim.cmd.source(vimrc)

-- Disable line numbering:
vim.cmd([[set nonumber norelativenumber]])

----- Plugins ------
local lazy = require("user.lazy")

-- Setup the "Lazy" plugin manager.
--
-- Instead of supplying a large table containing all the plugins, the "plugins"
-- string causes Lazy construct the table by loading everything in
-- 'lua/plugins/*.lua'.

local function gruvbox_config(plugin, opts)
  require("gruvbox").setup(opts)
  -- load the colorscheme here
  vim.cmd([[colorscheme gruvbox]])
end

-- The minimal set of plugins you'd like loaded here:
local plugins = {
  { "ellisonleao/gruvbox.nvim",
    lazy = false,
    priority = 1000,
    config = gruvbox_config,
  },
}

require("lazy").setup(plugins, lazy.basic_opts)
