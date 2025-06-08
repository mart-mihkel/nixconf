vim.keymap.set({ "n", "v" }, "j", "gj")
vim.keymap.set({ "n", "v" }, "k", "gk")

vim.keymap.set({ "n", "v" }, "<C-j>", "<cmd>cnext<CR>")
vim.keymap.set({ "n", "v" }, "<C-k>", "<cmd>cprevious<CR>")

vim.keymap.set({ "n", "v" }, "<C-l>", "<cmd>lnext<CR>")
vim.keymap.set({ "n", "v" }, "<C-h>", "<cmd>lprevious<CR>")
