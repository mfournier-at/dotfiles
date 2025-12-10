-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
--
-- Disable LazyVim auto format

vim.g.autoformat = false
vim.o.background = "light"


-- Option A: cwd stays where Neovim is launched, always.
-- Disable all automatic root detection / auto-chdir from LazyVim.

-- LazyVim rooter settings
vim.g.lazyvim_root_options = {
  autodetect = false,  -- do NOT auto-detect project roots
  autochdir = false,   -- do NOT change cwd automatically
}

-- Disable Neovim's legacy autochdir as well
vim.opt.autochdir = false


-- Let Neovim set the terminal title
vim.o.title = true

-- Customize the title
vim.o.titlestring = "v—%{fnamemodify(getcwd(), ':t')}"

-- don't autoclose term buffers
vim.g.lazyvim_hide_term_buffers = false

