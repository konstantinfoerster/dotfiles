vim.schedule(function()
  vim.pack.add({
    { src = "https://github.com/mason-org/mason.nvim", name = "mason.nvim" },
    { src = "https://github.com/mfussenegger/nvim-dap", name = "nvim-dap" },
    { src = "https://github.com/rcarriga/nvim-dap-ui", name = "nvim-dap-ui" },
    { src = "https://github.com/jay-babu/mason-nvim-dap.nvim", name = "mason-nvim-dap.nvim" },
    { src = "https://github.com/leoluz/nvim-dap-go", name = "nvim-dap-go" },
    { src = "https://github.com/nvim-neotest/nvim-nio", name = "nvim-nio" },
  })

  require("mason-nvim-dap").setup({
    handlers = {},

    ensure_installed = {
      "delve",
    },
  })

  local dap = require("dap")
  vim.keymap.set("n", "<F5>", dap.continue, { desc = "Debug: Start/Continue" })
  vim.keymap.set("n", "<F1>", dap.step_into, { desc = "Debug: Step Into" })
  vim.keymap.set("n", "<F2>", dap.step_over, { desc = "Debug: Step Over" })
  vim.keymap.set("n", "<F3>", dap.step_out, { desc = "Debug: Step Out" })
  vim.keymap.set("n", "<F6>", dap.restart, { desc = "Debug: Restart" })
  vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint, { desc = "Debug: Toggle [B]reakpoint" })
  vim.keymap.set("n", "<leader>B", function()
    dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
  end, { desc = "Debug: Set [B]reakpoint with condition" })

  local dapui = require("dapui")
  dapui.setup()
  dap.listeners.after.event_initialized["dapui_config"] = dapui.open
  dap.listeners.before.event_terminated["dapui_config"] = dapui.close
  dap.listeners.before.event_exited["dapui_config"] = dapui.close

  -- toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
  vim.keymap.set("n", "<leader>dl", dapui.toggle, { desc = "Debug: See last session result" })

  require("dap-go").setup()
end)
