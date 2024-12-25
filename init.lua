-- Neovim Configuration

---- Debugging Help ----

---- Vim Commands

-- :messages                  :: To see print messages.
-- :map, :nmap, :imap, :vmap  :: Display the key mappings.

-- :hi                        :: To display all the highlight groups.
-- :verbose hi <Group>        :: To see when a particular highlight group was last set.
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

------ Colorscheme -----

-- The old peachpuff color scheme is missing defaults for some of the newer highlight groups:
local colorscheme_augroup = vim.api.nvim_create_augroup("ColorSchemeGroup", {
  clear = false
})

vim.api.nvim_create_autocmd({"ColorScheme"}, {
  pattern = {"peachpuff"},
  group = colorscheme_augroup,
  callback = function(ev)
    vim.print("Fixing peachpuff")
    vim.api.nvim_set_hl(0, 'DiagnosticInfo', { fg = 'DarkBlue' })
    vim.api.nvim_set_hl(0, 'DiagnosticHint', { fg = 'SlateBlue'})
    vim.api.nvim_set_hl(0, 'DiagnosticOk', { fg = 'DarkGreen' })
    vim.api.nvim_set_hl(0, 'DiagnosticWarn', { fg = 'DarkGreen' })
  end
})

vim.cmd.colorscheme("peachpuff")

-- Add descriptions to vimrc-common mappings:

vim.keymap.set("n", "<Leader>ul", "<cmd>call ToggleLineNumberType()<cr>",
  {desc = "Line numbers"})

vim.keymap.set("n", "<Leader>uw", "<cmd>call ToggleTrailingSpaceHighlight()<cr>",
  {desc = "Trailing whitespace"})

vim.keymap.set("n", "<Leader>fw", "<cmd>call TrimTrailingWhitespace()<cr>",
  {desc = "Trim whitespace"})

----- Lazy.nvim Package Manager -----

-- Lazy.nvim is a popular package manager for Neovim written in Lua.  Once enabled, it will subsume
-- Vim's normal package management.

-- Note: Lazy.nvim is configured to load everything under the 'lua/plugins' directory.
require("site.lazy")
