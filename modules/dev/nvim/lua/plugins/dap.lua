return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui",
    "nvim-neotest/nvim-nio",
  },

  config = function()
    local dap = require("dap")
    local dapui = require("dapui")
    dapui.setup()

    dap.adapters.gdb = {
      type = "executable",
      command = "gdb",
      args = { "--interpreter=dap", "--eval-command", "set print pretty on" },
    }

    dap.configurations.c = {
      {
        name = "Launch",
        type = "gdb",
        request = "launch",
        program = function()
          return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
        end,
        cwd = "${workspaceFolder}",
        stopAtBeginningOfMainSubprogram = false,
      },
    }
    dap.configurations.cpp = dap.configurations.c

    dap.listeners.before.attach.dapui_config = dapui.open
    dap.listeners.before.launch.dapui_config = dapui.open
    dap.listeners.before.event_terminated.dapui_config = dapui.close
    dap.listeners.before.event_exited.dapui_config = dapui.close

    vim.keymap.set("n", "<F5>", dap.continue, { desc = "Debug: start/continue" })
    vim.keymap.set("n", "<F10>", dap.step_over, { desc = "Debug: step over" })
    vim.keymap.set("n", "<F11>", dap.step_into, { desc = "Debug: step into" })
    vim.keymap.set("n", "<F12>", dap.step_out, { desc = "Debug: step out" })
    vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint, { desc = "Debug: toggle breakpoint" })
    vim.keymap.set("n", "<leader>dq", dap.terminate, { desc = "Debug: stop" })
    vim.keymap.set("n", "<leader>du", dapui.toggle, { desc = "Debug: toggle UI" })
    vim.keymap.set({ "n", "v" }, "<leader>de", dapui.eval, { desc = "Debug: eval expression" })
  end,
}
