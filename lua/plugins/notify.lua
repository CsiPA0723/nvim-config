---@type LazyPluginSpec[]
return {
	{
		'j-hui/fidget.nvim',
		lazy = false,
		dependencies = {
			{
				'rcarriga/nvim-notify',
				opts = { fps = 60, render = 'compact', stages = 'slide' },
			},
		},
		opts = {
			notification = {
				override_vim_notify = true,
				redirect = function(msg, level, opts)
					local integNotify = require('fidget.integration.nvim-notify')
					if opts and opts.on_open then
						return integNotify.delegate(msg, level, opts)
					end
				end,
			},
		},
		config = function(_, opts)
			opts.notification.configs = {
				default = require('fidget.notification').default_config,
				session = vim.tbl_extend('keep', {
					name = 'Session',
					icon = '❰❰',
					ttl = 8,
				}, require('fidget.notification').default_config),
			}
			require('fidget').setup(opts)
		end,
	},
}
