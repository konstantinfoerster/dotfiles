vim.schedule(function()
  vim.pack.add({
    -- realtime color highlighting
    { src = "https://github.com/brenoprata10/nvim-highlight-colors", name = "nvim-highlight-colors" },
    -- highlighting other uses of the word under the cursor
    { src = "https://github.com/RRethy/vim-illuminate", name = "vim-illuminate" },
    -- better input and selection picker
    -- show indent guides
    { src = "https://github.com/folke/snacks.nvim", name = "snacks.nvim" },
  })

  require("nvim-highlight-colors").setup({})

  require("illuminate").configure({})

  require("snacks").setup({
    input = { enabled = true },
    indent = {
      enabled = true,
      animate = {
        enabled = false,
      },
    },
    picker = { enabled = true },
  })
end)

vim.api.nvim_create_autocmd("BufRead", {
  once = true,
  callback = vim.schedule_wrap(function()
    -- highlight and search for todo comments
    vim.pack.add({
      { src = "https://github.com/nvim-lua/plenary.nvim", name = "plenary.nvim" },
      { src = "https://github.com/folke/todo-comments.nvim", name = "todo-comments.nvim" },
    })

    require("todo-comments").setup({
      signs = false,
    })

    vim.keymap.set("n", "<leader>tc", "<Cmd>TodoTrouble<CR>", { desc = "[T]rouble [C]omments" })
  end),
})

-- custom statusline

local function gitStatus()
  local git_info = vim.b.gitsigns_status_dict

  if not git_info or git_info.head == "" then
    return ""
  end

  local head = git_info.head
  local added = (git_info.added and git_info.added > 0) and (" %#GitSignsAdd#+" .. git_info.added .. "%*") or ""
  local changed = (git_info.changed and git_info.changed > 0) and (" %#GitSignsChange#~" .. git_info.changed .. "%*")
    or ""
  local removed = (git_info.removed and git_info.removed > 0) and (" %#GitSignsDelete#-" .. git_info.removed .. "%*")
    or ""

  local max_branch = 30
  if #head > max_branch then
    head = head:sub(1, max_branch) .. "..."
  end

  return table.concat({
    " [",
    "%#GitSignsAdd#",
    head,
    "%*",
    added,
    changed,
    removed,
    "]",
  })
end

local function diagnosticStatus()
  local counts = vim.diagnostic.count(0)
  local errCount = counts[vim.diagnostic.severity.ERROR] or 0
  local warnCount = counts[vim.diagnostic.severity.WARN] or 0
  if warnCount == 0 and errCount == 0 then
    return ""
  end

  local errors = errCount > 0 and ("%#errormsg#󰅚 " .. errCount .. "%*") or ""
  local warnings = warnCount > 0 and ("%#warningmsg#󰀪 " .. warnCount .. "%*") or ""
  local sep = warnCount > 0 and errCount > 0 and " " or ""

  return " " .. errors .. sep .. warnings
end

local function fileFormat()
  local ff = vim.bo.fileformat
  if ff ~= "unix" then
    return " %#warningmsg#" .. ff .. "%*"
  end
  return ""
end

local function fileEncoding()
  local fenc = vim.bo.fileencoding
  if fenc ~= "" then
    return " " .. fenc
  end
  return ""
end

local lsp_msg = ""
local function lspStatus()
  if lsp_msg == "" then
    return ""
  end

  return " " .. lsp_msg
end

local lsp_timer = assert(vim.uv.new_timer(), "failed to create new timer")
vim.api.nvim_create_autocmd("LspProgress", {
  callback = function(ev)
    local value = ev.data and ev.data.params and ev.data.params.value
    if not value then
      return
    end

    if value.kind == "end" then
      lsp_msg = ""
      -- stop any running timer, to avoid unnecessary redraw
      lsp_timer:stop()
      vim.cmd.redrawstatus()
      return
    end

    local parts = value.title or ""
    if value.message then
      parts = parts .. " " .. value.message
    end
    if value.percentage then
      parts = parts .. " (" .. value.percentage .. "%%)"
    end
    lsp_msg = parts

    lsp_timer:stop()
    -- redraw every Xms
    lsp_timer:start(
      50,
      0,
      vim.schedule_wrap(function()
        vim.cmd.redrawstatus()
      end)
    )
  end,
})

_G.Statusline = {}
function Statusline.print()
  -- %f = relative file path, could be too long
  -- %m = modified flag, shows [+]
  -- %= = split into left and right pane
  -- %y = filetype, shows [type]
  -- %r = read only flag, shows [RO]
  -- %l = line position
  -- %c = line column
  return table.concat({
    gitStatus(),
    diagnosticStatus(),
    " %<%f",
    " %m%r",
    "%=",
    lspStatus(),
    fileEncoding(),
    fileFormat(),
    " %y %l:%c ",
  })
end

-- reset highlight group
vim.api.nvim_set_hl(0, "StatusLine", {})
-- set custom statusline
vim.o.statusline = "%!v:lua.Statusline.print()"
