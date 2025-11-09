return {
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters = {
        markdownlint = {
          -- Set this to false to disable markdownlint
          enabled = false, 
          -- Or, if you want to disable specific rules, you can add args here
          -- args = { "--disable", "MD013", "--" }, 
        },
      },
    },
  },
}
