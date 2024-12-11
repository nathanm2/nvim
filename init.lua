-- Neovim Configuration

---- Debugging Help ----

---- Vim Commands

-- :messages                  :: To see print messages.
-- :map, :nmap, :imap, :vmap  :: Display the key mappings.

---- Lua Commands:

-- vim.print(<table>)         :: Pretty-print a Lua table.


----- Common Vim/Nvim Config -----

-- Source a common vim/nvim config file.  Useful for those options you'd like to keep common between
-- vim/nvim.
--
-- NOTE: This must be done early since it sets the leader key.
local config_dir = vim.fn.stdpath("config")
local vimrc = config_dir .. "/vimrc-common.vim"
vim.cmd.source(vimrc)


----- Lazy.nvim Package Manager -----

-- Lazy.nvim is a popular package manager for Neovim written in Lua.  Lazy.nvim will subsume Vim's
-- normal package management once enabled.

-- Start the Lazy.nvim package manager.  It's configured to load everything under the 'lua/plugins'
-- directory.
require("site.lazy")
