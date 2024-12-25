return {
  {
    "nathanm2/cscope_maps.nvim",
    opts = {
      -- Don't ask for input:
      skip_input_prompt = true,
      prefix = "<C-\\>",

      cscope = {
        db_file = "./.cscope/cscope.out",
        picker = "mini-pick",
        skip_picker_for_single_result = true,

        project_rooter = {
          enable = true,
        }
      }
    }
  }
}

