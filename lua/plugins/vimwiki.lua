return {
  {
    "vimwiki/vimwiki",
    keys = {"<leader>ww"},
    init = function()
      vim.g.vimwiki_list = {
        {
          path = "~/notes/vimwiki/nvidia"
        },
        {
          path = "~/notes/vimwiki/public"
        }
      }
    end
  }
}
