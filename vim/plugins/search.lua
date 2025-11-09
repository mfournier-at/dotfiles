return {
   {
    "ibhagwan/fzf-lua",
    optional = true,
    opts = function(_, opts)
      local actions = require("fzf-lua.actions")
      return vim.tbl_deep_extend("force", opts, {
        files = {
          cwd_prompt = false,
          actions = {
            ["ctrl-i"] = { actions.toggle_ignore },
            ["ctrl-h"] = { actions.toggle_hidden },
          },
          hidden = true
        },
        grep = {
          actions = {
            ["ctrl-i"] = { actions.toggle_ignore },
            ["ctrl-h"] = { actions.toggle_hidden },
          },
          hidden = true
        },
      })
    end,
  },
}
