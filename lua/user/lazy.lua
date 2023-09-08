-- Lazy.nvim is a modern plugin manager for Neovim.

-- Auto installation for Lazy.nvim:
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local M = {}  

-- Options to Lazy.nvim:
M.basic_opts = {
  ui = {
     border = "rounded"
  },
}

function M.setup(spec, opts)
  require("lazy").setup(spec, opts or M.basic_opts)
end

return M
