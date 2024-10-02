-- debug.lua
--
-- Shows how to use the DAP plugin to debug your code.
--
-- Primarily focused on configuring the debugger for Go, but can
-- be extended to other languages as well. That's why it's called
-- kickstart.nvim and not kitchen-sink.nvim ;)

---@type LazyPluginSpec[]
return {
	{
		'mfussenegger/nvim-dap',
		dependencies = {
			'rcarriga/nvim-dap-ui',
			'nvim-neotest/nvim-nio',
			'williamboman/mason.nvim',
			'jay-babu/mason-nvim-dap.nvim',
			'leoluz/nvim-dap-go',
		},
		config = function()
			local dap = require 'dap'
			local dapui = require 'dapui'

			require('mason-nvim-dap').setup {
				-- Makes a best effort to setup the various debuggers with
				-- reasonable debug configurations
				automatic_setup = true,
				automatic_installation = false,

				-- You can provide additional configuration to the handlers,
				-- see mason-nvim-dap README for more information
				handlers = {
					function(config)
						-- all sources with no handler get passed here

						-- Keep original functionality
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

				-- You'll need to check that you have the required things installed
				-- online, please don't ask me how to install them :)
				ensure_installed = {
					-- Update this to ensure that you have the debuggers for the langs you want
					'delve',
				},
			}

			-- Dap UI setup
			-- For more information, see |:help nvim-dap-ui|
			---@diagnostic disable-next-line: missing-fields
			dapui.setup {
				-- Set icons to characters that are more likely to work in every terminal.
				--    Feel free to remove or use ones that you like more! :)
				--    Don't feel like these are good choices.
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
			}

			dap.listeners.after.event_initialized['dapui_config'] = dapui.open
			dap.listeners.before.event_terminated['dapui_config'] = dapui.close
			dap.listeners.before.event_exited['dapui_config'] = dapui.close

			-- Install golang specific config
			require('dap-go').setup()
		end,
	},
}
