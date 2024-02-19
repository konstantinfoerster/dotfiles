-- map leader to space
vim.g.mapleader = " "

-- disable recording
vim.keymap.set("n", "q", "<nop>", { desc = "Disable recording" })

-- fast buffer change
vim.keymap.set("n", "<leader><leader>", "<c-^>", { desc = "Switch to last buffer" })

-- diff jumps for german layouts
vim.keymap.set("n", "üc", "[c") -- next diff hunk
vim.keymap.set("n", "+c", "]c") -- previous diff hunk

-- tabs
vim.keymap.set("n", "<leader>tc", ":tabclose<CR>") -- close tab

-- window
vim.keymap.set("n", "<C-w>h", ":vertical resize -15<CR>") -- make smaller
vim.keymap.set("n", "<C-w>l", ":vertical resize +15<CR>") -- make wider

-- disable space since it's the leader key
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- center buffer
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
