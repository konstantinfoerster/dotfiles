-- map leader to space
vim.g.mapleader = " "

-- disable recording
vim.keymap.set("n", "q", "<nop>")

-- fast buffer change
vim.keymap.set("n", "<leader><leader>", "<c-^>") -- toggle between buffers

-- diff jumps for german layouts
vim.keymap.set("n", "üc", "[c") -- next diff hunk
vim.keymap.set("n", "+c", "]c") -- previous diff hunk

-- tabs
vim.keymap.set("n", "<leader>tc", ":tabclose<CR>") -- toggle between buffers


-- window
vim.keymap.set("n", "<C-w>h", ":vertical resize -15<CR>") -- make smaller
vim.keymap.set("n", "<C-w>l", ":vertical resize +15<CR>") -- make wider
