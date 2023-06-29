-- Neovim Configuration

-- Source our common vim/nvim config.
--
-- For config options that you'd like to keep common between vim/nvim:
local config_dir = vim.fn.stdpath("config")
local vimrc = config_dir .. "/vimrc-common.vim"
vim.cmd.source(vimrc)


----- Key Maps ----- 

-- Make it easier to edit the keymappings:
local keymap_opts = { silent = true }
local keymap = vim.api.nvim_set_keymap
keymap("n", "<Leader>on", ":edit $MYVIMRC<CR>", keymap_opts)
keymap("n", "<Leader>ov", string.format(":edit %s<CR>", vimrc), keymap_opts)

-- Terminal --
-- Better terminal navigation
keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", keymap_opts)
keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", keymap_opts)
keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", keymap_opts)
keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", keymap_opts)

----- Neovide -----

-- Set the GUI font:
vim.opt.guifont = "DejaVuSansMono Nerd Font Mono:h10"
-- vim.opt.guifont = "DroidSansM Nerd Font Mono:h11"

-- Neovide cursor animation time in seconds:
--   0 = disables cursor animation.
vim.g.neovide_cursor_animation_length = 0

-- Plugins --
require("user.lazy")

-- LSP Formatting Setup --
local format = require("user.lsp.format")
format.setup{autoformat = true}
vim.keymap.set("n", "<Leader>uf", format.toggle, {
  silent = true,
  desc = "Toggle autoformat on write (LSP)",
})
