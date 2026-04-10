local dap = require("dap")
local ui = require("dapui")
local dap_virtual_text = require("nvim-dap-virtual-text")
local wk = require("which-key")

require("dap-go").setup()

-- Dap Virtual Text
dap_virtual_text.setup()

-- dap.configurations = {
-- 	go = {
-- 		{
-- 			type = "delve",
-- 			name = "Debug",
-- 			request = "launch",
-- 			program = "${file}",
-- 		},
-- 		{
-- 			type = "delve",
-- 			name = "Debug test", -- configuration for debugging test files
-- 			request = "launch",
-- 			mode = "test",
-- 			program = "${file}",
-- 		},
-- 		-- works with go.mod packages and sub packages
-- 		{
-- 			type = "delve",
-- 			name = "Debug test (go.mod)",
-- 			request = "launch",
-- 			mode = "test",
-- 			program = "./${relativeFileDirname}",
-- 		},
-- 	},
-- }

-- Dap UI

ui.setup()

vim.fn.sign_define("DapBreakpoint", { text = "🐞" })

-- dap.listeners.before.attach.dapui_config = function()
-- 	ui.open()
-- end
-- dap.listeners.before.launch.dapui_config = function()
-- 	ui.open()
-- end
-- dap.listeners.before.event_terminated.dapui_config = function()
-- 	ui.close()
-- end
-- dap.listeners.before.event_exited.dapui_config = function()
-- 	ui.close()
-- end

dap.listeners.after.event_initialized["dapui_config"] = function()
	ui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
	ui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
	ui.close()
end

-- 5. Add custom configs WITHOUT wiping out the dap-go defaults
-- We use the type "go" because that is what dap-go registers
table.insert(dap.configurations.go, {
	type = "go",
	name = "Debug (Build Flags)",
	request = "launch",
	program = "${file}",
	buildFlags = "-tags=unit", -- Example of a custom config
})

-- Keymaps
wk.add({
	-- Debugger
	{
		"<leader>d",
		group = "Debugger",
		nowait = true,
		remap = false,
	},
	{
		"<leader>dt",
		function()
			require("dap").toggle_breakpoint()
		end,
		desc = "Toggle Breakpoint",
		nowait = true,
		remap = false,
	},
	{
		"<leader>dc",
		function()
			require("dap").continue()
		end,
		desc = "Continue",
		nowait = true,
		remap = false,
	},
	{
		"<leader>di",
		function()
			require("dap").step_into()
		end,
		desc = "Step Into",
		nowait = true,
		remap = false,
	},
	{
		"<leader>do",
		function()
			require("dap").step_over()
		end,
		desc = "Step Over",
		nowait = true,
		remap = false,
	},
	{
		"<leader>du",
		function()
			require("dap").step_out()
		end,
		desc = "Step Out",
		nowait = true,
		remap = false,
	},
	{
		"<leader>dr",
		function()
			require("dap").repl.open()
		end,
		desc = "Open REPL",
		nowait = true,
		remap = false,
	},
	{
		"<leader>dl",
		function()
			require("dap").run_last()
		end,
		desc = "Run Last",
		nowait = true,
		remap = false,
	},
	{
		"<leader>dq",
		function()
			require("dap").terminate()
			require("dapui").close()
			require("nvim-dap-virtual-text").toggle()
		end,
		desc = "Terminate",
		nowait = true,
		remap = false,
	},
	{
		"<leader>db",
		function()
			require("dap").list_breakpoints()
		end,
		desc = "List Breakpoints",
		nowait = true,
		remap = false,
	},
	{
		"<leader>de",
		function()
			require("dap").set_exception_breakpoints({ "all" })
		end,
		desc = "Set Exception Breakpoints",
		nowait = true,
		remap = false,
	},
	{
		"<leader>du",
		function()
			require("dapui").toggle()
		end,
		desc = "Toggle Debugger UI",
	},
})
