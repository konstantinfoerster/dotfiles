-- map leader to space
vim.g.mapleader = " "

-- disable recording
vim.keymap.set("n", "q", "<nop>", { desc = "Disable recording" })

-- fast buffer change
vim.keymap.set("n", "<leader><leader>", "<c-^>", { desc = "Switch to last buffer" })

-- diff jumps for german layouts
vim.keymap.set("n", "+c", "]c", { desc = "Next diff hunk" })
vim.keymap.set("n", "üc", "[c", { desc = "Previous diff hunk" })

-- tabs
vim.keymap.set("n", "<leader>qq", ":tabclose<CR>", { desc = "Close tab" })

-- window
vim.keymap.set("n", "<C-w>h", ":vertical resize -15<CR>", { desc = "Vertical resize (smaller)" })
vim.keymap.set("n", "<C-w>l", ":vertical resize +15<CR>", { desc = "Vertical resize (wider)" })

-- disable space since it's the leader key
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true, desc = "Disable space key" })

-- center buffer
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Page up and center" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Page down and center" })
