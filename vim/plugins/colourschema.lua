-- return {
--     { "sainnhe/everforest", name = "everforest", priority = 1000 },
--     { "rose-pine/neovim", as = "rose-pine", priority = 1000 },
--     { "miikanissi/modus-themes.nvim", priority = 1000 },
--
--   {
--     "LazyVim/LazyVim",
--     opts = {
--       colorscheme = "rose-pine-dawn"
--       --colorscheme = "shine"
--     },
--   }
-- }
--
return {
  {
    "nyoom-engineering/oxocarbon.nvim",
    -- Add in any other configuration;
    --   event = foo,
    --   config = bar
    --   end,
  },
  {
    "zenbones-theme/zenbones.nvim",
    -- Optionally install Lush. Allows for more configuration or extending the colorscheme
    -- If you don't want to install lush, make sure to set g:zenbones_compat = 1
    -- In Vim, compat mode is turned on as Lush only works in Neovim.
    dependencies = "rktjmp/lush.nvim",
    lazy = false,
    priority = 1000,
    -- you can set set configuration options here
    -- config = function()
    --     vim.g.zenbones_darken_comments = 45
    --     vim.cmd.colorscheme('zenbones')
    -- end
  },
  -- {
  --   "rose-pine/neovim",
  --   name = "rose-pine",
  --   priority = 1000,
  --   opts = {
  --     -- define the highlight group we'll reference from 'guicursor'
  --     highlight_groups = {
  --       -- swap fg/bg if the cursor/text look inverted in your terminal
  --       InsertCursor = { fg = "#000000", bg = "#FF5F1F", inherit = false }, -- neon orange
  --     },
  --   },
  --   config = function(_, opts)
  --     -- ensure truecolor so the exact hex is used
  --     vim.opt.termguicolors = true
  --
  --     require("rose-pine").setup(opts)
  --     vim.cmd.colorscheme("rose-pine-dawn")
  --
  --     -- mode-specific cursors
  --     -- normal/visual/cmd/showmatch: block
  --     -- insert/command-line-insert/visual-exclude: vertical bar using our InsertCursor HL
  --     -- replace modes: horizontal
  --     -- NOTE: no "a:Cursor/lCursor" fallback so we don't override the insert spec
  --     vim.opt.guicursor = {
  --       "n-v-c-sm:block",
  --       "i-ci-ve:ver25-InsertCursor",
  --       "r-cr:hor20",
  --       "o:hor50",
  --     }
  --   end,
  -- },
  {
    "p00f/alabaster.nvim",
    name = "alabaster",
    priority = 1000,
    config = function()
      -- Must set the global *before* applying the colorscheme
      vim.g.alabaster_floatborder = true

      -- You can also explicitly set light background here if needed
      vim.o.background = "light"

      -- Then apply the theme
      vim.cmd.colorscheme("alabaster")
    end,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "alabaster",
    },
  },
}
