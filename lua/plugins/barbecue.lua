return {
	{
		'utilyre/barbecue.nvim',
		name = 'barbecue',
		version = '*',
		dependencies = {
			'SmiteshP/nvim-navic',
			'nvim-tree/nvim-web-devicons',
		},
		event = 'VeryLazy',
		opts = {
			create_autocmd = false,
			show_modified = true,
			theme = 'catppuccin-macchiato',
		},
		config = function(_, opts)
			opts['lead_custom_section'] = function()
				return { { ' ', 'WinBar' } }
			end

			require('barbecue').setup(opts)

			vim.api.nvim_create_autocmd({
				'WinResized',
				'BufWinEnter',
				'CursorHold',
				'InsertLeave',
				'BufModifiedSet',
			}, {
				group = vim.api.nvim_create_augroup('barbecue.updater', {}),
				callback = function()
					require('barbecue.ui').update()
				end,
			})
		end,
	},
}
