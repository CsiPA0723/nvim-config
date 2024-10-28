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
				window = { winblend = 0 },
			},
		},
		config = function(_, opts)
			require('fidget').setup(opts)
			require('fidget.notification').set_config('session', {
				name = 'Session',
				icon = '❰❰',
				ttl = 8,
			}, false)
		end,
	},
}
