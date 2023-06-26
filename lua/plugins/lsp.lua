local function config(plugin, opts)
  -- Force the "signcolumn" to stay open.
  --
  -- Otherwise it causes the buffer to shift to the right when we're editing.
  vim.opt.signcolumn = "yes"

  local lspconfig = require("lspconfig")
  lspconfig.rust_analyzer.setup {}
  lspconfig.pylsp.setup{}
  lspconfig.clangd.setup{
    -- clangd uses 'clang-format' to format the code.  If a .clang-format file
    -- cannot be found we want to fallback to NOT performing any formatting.
    -- The default behaviour is to fallback to the LLVM style.
    cmd = { 'clangd', '--fallback-style=none' }
  }

  vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(args)
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      vim.b.lsp_format_available = 
        client.server_capabilities.documentFormattingProvider
    end
  })

  vim.g.lsp_autoformat = true

  vim.api.nvim_create_autocmd('BufWritePre', {
    pattern = {"*.c", "*.h", "*.C", "*.H", "*.cc", "*.cpp"},
    callback = function(args)
      if vim.g.lsp_autoformat and vim.b.lsp_format_available then
        vim.lsp.buf.format()
      end
    end
  })

  local function toggle_lsp_autoformat()
    vim.g.lsp_autoformat = not vim.g.lsp_autoformat
    if vim.g.lsp_autoformat then
      print("Enabled format on save")
    else
      print("Disabled format on save")
    end
  end

  vim.keymap.set("n", "<Leader>uf", toggle_lsp_autoformat,
    {desc = "Toggle format on save"})

end


return {
  { "neovim/nvim-lspconfig",
    lazy=false,
    config = config,
  }
}
