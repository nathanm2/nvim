
-- The `neovim-qt` Debian package installs a `/usr/share/nvim-qt/runtime/plugin/nvim_gui_shim.vim`
-- file, but enabling Lazy prevents this from being loaded.  To work around this, we install this
-- shim via Lazy:
return {
  { "equalsraf/neovim-gui-shim" }
}
