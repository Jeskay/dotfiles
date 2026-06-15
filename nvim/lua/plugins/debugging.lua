return {
	"mfussenegger/nvim-dap",
	dependencies = {
		-- Debugger UI
		"rcarriga/nvim-dap-ui",
		-- Go specific debugger
		"leoluz/nvim-dap-go",
		-- Required dependency
		"nvim-neotest/nvim-nio",
		-- Show variables values as virtual text
		"theHamsta/nvim-dap-virtual-text",
	},
	config = function()
		local dap = require("dap")
		local dapui = require("dapui")
		dapui.setup()
		-- Automatically open/close UI
		dap.listeners.after.event_initialized["dapui_config"] = dapui.open
		dap.listeners.before.event_terminated["dapui_config"] = dapui.close
		dap.listeners.before.event_exited["dapui_config"] = dapui.close

		require("nvim-dap-virtual-text").setup()

		-- Bun adapter
		dap.adapters["pwa-node"] = {
			type = "server",
			host = "localhost",
			port = "${port}",
			executable = {
				command = vim.fn.stdpath("data") .. "/mason/bin/js-debug-adapter",
				args = { "${port}" },
			},
		}
		-- Bun debugger
		local bun_config = {
			{
				type = "pwa-node",
				request = "attach",
				name = "Attach to running Bun process",
				cwd = "${workspaceFolder}",
        localRoot = "${workspaceFolder}",
        remoteRoot = "${workspaceFolder}",
				-- Direct connection using Bun's WebSocket pipeline
				websocketAddress = function()
					local port = vim.fn.input("Port [Default:6499]: ", "6499")
					return "ws://localhost:" .. port .. "/"
				end,
				sourceMaps = true,
				protocol = "inspector",
				skipFiles = { "<node_internals>/**", "node_modules/**", "**/bun:wrap/**" },
			},
		}
		dap.configurations.typescript = bun_config
		dap.configurations.javascript = bun_config

		-- Go debugger
		require("dap-go").setup({
			dap_configurations = {
				{
					type = "go",
					name = "Debug (Within Folder)",
					request = "launch",
					program = "${file}",
					cwd = "${workspaceFolder}",
					outputMode = "remote",
				},
			},
			delve = {
				patch = function()
					local mason_delve = vim.fn.stdpath("data") .. "/mason/bin/dlv"
					if vim.fn.executable(mason_delve) == 1 then
						return mason_delve
					end
					-- Use system delve installation instead
					return vim.fn.exepath("dlv") ~= "" and vim.fn.exepath("dlv") or "dlv"
				end,
			},
		})

		-- Keymaps
		vim.keymap.set("n", "<F5>", function()
			dap.continue()
		end)
		vim.keymap.set("n", "<F10>", function()
			dap.step_over()
		end)
		vim.keymap.set("n", "<F11>", function()
			dap.step_into()
		end)
		vim.keymap.set("n", "<F12>", function()
			dap.step_out()
		end)
		vim.keymap.set("n", "<leader>b", function()
			dap.toggle_breakpoint()
		end)
		vim.keymap.set("n", "<leader>B", function()
			dap.set_breakpoint()
		end)
		vim.keymap.set("n", "<leader>dc", function()
			dap.continue()
		end)
		vim.keymap.set("n", "<leader>du", function()
			dapui.toggle({})
		end)
		vim.keymap.set("n", "<leader>di", function()
			require("dapui").eval(nil, { enter = true })
		end)
		vim.keymap.set("n", "<leader>do", function()
			dap.step_out()
		end)
		vim.keymap.set("n", "<leader>dl", function()
			dap.run_last()
		end)
	end,
}
