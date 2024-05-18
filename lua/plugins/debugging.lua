return {
	{
		"nvim-neotest/nvim-nio",
	},
	{
		"rcarriga/nvim-dap-ui",
	},
	{
		"julianolf/nvim-dap-lldb",
		dependencies = { "mfussenegger/nvim-dap" },
		opts = {},
	},
	{
		"mfussenegger/nvim-dap",
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")

			require("dap-lldb").setup({
        configurations = {
          swift = {
            {
              name = "Debug SwiftFitTests",
              type = "lldb",
              request = "launch",
              program = "/Applications/Xcode.app/Contents/Developer/usr/bin/xctest",
              cwd = "${workspaceFolder}",
              stopOnEntry = false,
              args = { ".build/debug/swift-fitPackageTests.xctest" },
            }
          }
        }
      })
      require("dapui").setup({})

			dap.configurations.swift = {
        {
					name = "Debug SwiftFitTests",
					type = "lldb",
					request = "launch",
					program = "/Applications/Xcode.app/Contents/Developer/usr/bin/xctest",
					cwd = "${workspaceFolder}",
					stopOnEntry = false,
					args = { ".build/debug/swift-fitPackageTests.xctest" },
        }
      }

			dap.listeners.before.attach.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.launch.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated.dapui_config = function()
				dapui.close()
			end
			dap.listeners.before.event_exited.dapui_config = function()
				dapui.close()
			end
			vim.keymap.set("n", "<Leader>dt", dap.toggle_breakpoint, {})
			vim.keymap.set("n", "<Leader>dc", dap.continue, {})
		end,
	},
}
