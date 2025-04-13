---@type LazyPluginSpec[]
return {
	{
		'mfussenegger/nvim-dap',
		dependencies = {
			'rcarriga/nvim-dap-ui',
			'nvim-neotest/nvim-nio',
			'williamboman/mason.nvim',
			'jay-babu/mason-nvim-dap.nvim',
		},
		config = function()
			local dap = require 'dap'
			local dapui = require 'dapui'
			local wk = require 'which-key'

			wk.add({
				-- Buffer group
				{
					'<leader>bb',
					require('dap').toggle_breakpoint,
					desc = 'Debug: Toogle Breakpoint',
				},
				{
					'<leader>bB',
					function()
						require('dap').set_breakpoint(
							vim.fn.input('Breakpoint condition: ')
						)
					end,
					desc = 'Debug: Set Breakpoint',
				},
			})

			require('mason-nvim-dap').setup({
				automatic_setup = true,
				automatic_installation = false,
				ensure_installed = { 'delve' },
				handlers = {
					function(config)
						require('mason-nvim-dap').default_setup(config)
					end,
					--[[ python = function(config)
						config.adapters = {
							type = 'executable',
							command = '/usr/bin/python3',
							args = {
								'-m',
								'debugpy.adapter',
							},
						}
						require('mason-nvim-dap').default_setup(config) -- don't forget this!
					end, ]]
				},
			})

			---@diagnostic disable-next-line: missing-fields
			dapui.setup({
				icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
				---@diagnostic disable-next-line: missing-fields
				controls = {
					icons = {
						pause = '⏸',
						play = '▶',
						step_into = '⏎',
						step_over = '⏭',
						step_out = '⏮',
						step_back = 'b',
						run_last = '▶▶',
						terminate = '⏹',
						disconnect = '⏏',
					},
				},
			})

			dap.listeners.after.event_initialized['dapui_config'] = dapui.open
			dap.listeners.before.event_terminated['dapui_config'] = dapui.close
			dap.listeners.before.event_exited['dapui_config'] = dapui.close
		end,
	},
}
