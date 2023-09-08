-- A Minimimal Neovim Configuration

----- Basic Config -----

-- Source our common vim/nvim config.
--
-- For config options that you'd like to keep common between vim/nvim:
local config_dir = vim.fn.stdpath("config")
local vimrc = config_dir .. "/vimrc-common.vim"
vim.cmd.source(vimrc)

----- Plugins ------
--
-- The minimal set of plugins you'd like loaded here:
local spec = {
  { import = "plugins.colorschemes" },
}

require("user.lazy").setup(spec)
