-- map leader to space
vim.g.mapleader = " "

vim.keymap.set("n", "q", "<nop>", { remap = true })
vim.keymap.set("n", "<leader><leader>", "<c-^>") -- toggle between buffers
vim.keymap.set("n", "<leader>tc", ":tabclose<CR>") -- toggle between buffers

vim.keymap.set("n", "üc", "[c") -- next diff hunk
vim.keymap.set("n", "+c", "]c") -- previous diff hunk

vim.keymap.set("n", "+c", "]c") -- previous diff hunk
