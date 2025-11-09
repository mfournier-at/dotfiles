-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--


vim.keymap.set("n", "<leader>Y", "<cmd>:%y+<cr>", { desc = "Yank buffer to clipboard" })


vim.keymap.set("n", "<leader>fa", function()
  print(vim.fn.expand("%:."))
end, { desc = "Print relative path (project root)" })

vim.keymap.set("n", "<leader>fs", "<cmd>Neotree reveal<CR>", { desc = "Show current file in Neo-tree" })

vim.keymap.set("n", "<C-Space>", function()
  require("fzf-lua").live_grep({ cwd = vim.fn.getcwd() })
end, { desc = "Grep (cwd)" })


vim.keymap.set("n", "<leader>td", function()
  ---@diagnostic disable-next-line: missing-fields
  require("neotest").run.run({ strategy = "dap" })
end, { desc = "Debug nearest test" })

vim.keymap.set("n", "<leader>fl", ":e!<CR>", { desc = "Reload file" })

