local function config(plugin, opts)
  -- Force the "signcolumn" to stay open.
  --
  -- Otherwise it causes the buffer to shift to the right when we're editing.
  vim.opt.signcolumn = "yes"

  vim.diagnostic.config {
    severity_sort = true,
  }

  local lspconfig = require("lspconfig")
  lspconfig.rust_analyzer.setup {}
  lspconfig.pylsp.setup{}
  lspconfig.clangd.setup{
    -- clangd uses 'clang-format' to format the code.  If a .clang-format file
    -- cannot be found we want to fallback to NOT performing any formatting.
    -- The default behaviour is to fallback to the LLVM style.
    cmd = { 'clangd', '--fallback-style=none' }
  }
end


return {
  { "neovim/nvim-lspconfig",
    lazy=false,
    config = config,
  }
}
