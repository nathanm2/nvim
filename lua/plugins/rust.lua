-- Nvim's builtin support for Rust, as of version 0.9.0, doesn't handle newer
-- rustfmt options.  The rust.vim plugin in GitHub fixes this.
return {
  { "rust-lang/rust.vim",
    ft = "rust",
    config = function()
      -- Automatically run 'rustfmt' when saving a file:
      vim.g.rustfmt_autosave = 1
    end,
  }
}
