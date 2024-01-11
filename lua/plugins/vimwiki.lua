return {
  {
    "vimwiki/vimwiki",
    keys = {"<leader>ww"},
    init = function()
      vim.g.vimwiki_list = {
        {
          path = "~/notes/vimwiki/public"
        },
        {
          path = "~/notes/vimwiki/nvidia"
        }
      }
    end
  }
}
