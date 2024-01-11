-- Neovim Configuration

----- Basic Config -----

-- Source a common vim/nvim config:
--
-- Useful for those options you'd like to keep common between vim/nvim:
local config_dir = vim.fn.stdpath("config")
local vimrc = config_dir .. "/vimrc-common.vim"
vim.cmd.source(vimrc)

----- Key Maps ----- 

local keymap_opts = { silent = true }
local keymap = vim.api.nvim_set_keymap

-- Terminal --
-- Easier terminal navigation
keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", keymap_opts)
keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", keymap_opts)
keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", keymap_opts)
keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", keymap_opts)


----- Plugins ------

-- Configure LSP formatting:
local format = require("user.lsp.format")
format.setup{autoformat = false}

-- Setup the "Lazy" plugin manager.
--
-- By specifying a "plugins" string to setup we cause Lazy to construct the
-- table of plugins by loading everything in 'lua/plugins/*.lua'.  This should
-- be a bit more manageable then having everything in a giant table.
--
-- I do most plugin configuration down in the plugin files themselves, except
-- for keymappings which I prefer to have in one place to prevent accidental
-- clobbering.  The one exception to this latter rule are some of the
-- keymappings found in `vimrc-common.vim`.
--
require("user.lazy").setup("plugins")

-- Document our leader groups for 'which-key':
local wk = require("which-key")
wk.register({
  ["<leader>b"] = { name = "+buffer" },
  ["<leader>c"] = { name = "+code" },
  ["<leader>f"] = { name = "+file/find" },
  ["<leader>q"] = { name = "+quit/session" },
  ["<leader>u"] = { name = "+ui" },
})

vim.keymap.set("n", "<Leader>uf", format.toggle, { silent = true,
  desc = "Toggle autoformat on write (LSP)",
})

vim.keymap.set("n", "<Leader>cf",
  function()
    require("user.lsp.format").format{force = true}
  end,
  {
    silent = true,
    desc = "Format document (LSP)",
  }
)

-- Bufferline keymaps --
for i=1,9 do
  keymap("n", "<leader>" .. i, "<cmd>BufferLineGoToBuffer " .. i .. "<cr>",
  { silent=true, desc = "Buffer " .. i})
end

keymap("n", "<leader>0", "<cmd>lua require(\"bufferline\").go_to(1, true)<cr>",
{ silent=true, desc = "First buffer"})

keymap("n", "<leader>$", "<cmd>lua require(\"bufferline\").go_to(-1, true)<cr>",
{ silent=true, desc = "Last buffer"})

keymap("n", "<leader>bc", "<cmd>BufferLineTogglePin<cr>",
{ silent=true, desc = "Toggle pin"})

keymap("n", "<leader>bp", "<cmd>BufferLineTogglePin<cr>",
{ silent=true, desc = "Toggle pin"})

keymap("n", "<leader>bP", "<cmd>BufferLineGroupClose ungrouped<cr>",
{ silent=true, desc = "Delete non-pinned buffers"})
