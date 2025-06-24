-- map leader to space
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- mapping for german layout + to ] (applied only in normal mode)
-- sadly umlauts are not supported e.g. ü[ wont' work
vim.opt.langmap = "+]"

-- disable mouse
vim.opt.mouse = ""
vim.opt.guicursor = ""

-- show line numbers
vim.opt.number = true
-- show relativenumber
vim.opt.relativenumber = true

-- sync clipboard between OS and Neovim.
vim.opt.clipboard = "unnamedplus"

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
-- convert tabs to spaces
vim.opt.expandtab = true

-- enable break indent
vim.opt.breakindent = true
-- more clever indent
vim.opt.cindent = true

-- case-insensitive searching
vim.opt.ignorecase = true
vim.opt.smartcase = false

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

-- set completeopt to have a better completion experience
vim.opt.completeopt = "menuone,noselect"

vim.opt.hlsearch = false
vim.opt.incsearch = true

-- preview substitutions live, as you type!
vim.opt.inccommand = "split"

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

-- minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

-- keep signcolumn on by default
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 250
vim.opt.timeoutlen = 300

vim.opt.colorcolumn = "120"

-- Enable border for floating windows
vim.o.winborder = "rounded"

-- highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("YankHighlight", { clear = true }),
  callback = function()
    vim.hl.on_yank({ higroup = "IncSearch", timeout = "250" })
  end,
})

-- detect Jenkinsfiles
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "*.Jenkinsfile" },
  callback = function()
    vim.opt_local.filetype = "groovy"
  end,
})
