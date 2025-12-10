return {
  {
    "ibhagwan/fzf-lua",
    optional = true,
    opts = function(_, opts)
      local actions = require("fzf-lua.actions")

      return vim.tbl_deep_extend("force", opts, {
        files = {
          cwd_prompt = false,
          hidden = true,
          actions = {
            ["ctrl-i"] = { actions.toggle_ignore },
            ["ctrl-h"] = { actions.toggle_hidden },
          },
          -- IMPORTANT: fd ignores, not rg globs
          fd_opts = [[--type f --hidden --exclude __pycache__ --exclude *.pyc]],
        },
        grep = {
          hidden = true,
          actions = {
            ["ctrl-i"] = { actions.toggle_ignore },
            ["ctrl-h"] = { actions.toggle_hidden },
          },
          -- your existing rg globs DO work for grep
          rg_opts = (opts.grep and opts.grep.rg_opts or opts.rg_opts or "")
            .. " --glob '!**/__pycache__/' --glob '!**/*.pyc'",
        },
      })
    end,
  },
}

