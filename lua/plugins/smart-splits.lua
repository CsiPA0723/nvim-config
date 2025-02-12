---@type LazyPluginSpec[]
return {
	{
		'mrjones2014/smart-splits.nvim',
		build = './kitty/install-kittens.bash',
		event = 'VeryLazy',
		config = function(_, opts)
			local ss = require('smart-splits')
			local wk = require('which-key')
			ss.setup(opts)
			wk.add({
				{ -- Swap Buffer
					{ '<leader>a', group = 'Swap Buffer' },
					{ '<leader>ah', ss.swap_buf_left, desc = 'Swap with Left buffer' },
					{ '<leader>aj', ss.swap_buf_down, desc = 'Swap with Down Buffer' },
					{ '<leader>ak', ss.swap_buf_up, desc = 'Swap with Up Buffer' },
					{ '<leader>al', ss.swap_buf_right, desc = 'Swap with Right Buffer' },
				},
				{ -- resizing splits
					{ '<A-h>', ss.resize_left, desc = 'Resize Left' },
					{ '<A-j>', ss.resize_down, desc = 'Resize Down' },
					{ '<A-k>', ss.resize_up, desc = 'Resize Up' },
					{ '<A-l>', ss.resize_right, desc = 'Resize Right' },
				},
				{ -- moving between splits
					{ '<C-h>', ss.move_cursor_left, desc = 'Move to Left Plane' },
					{ '<C-j>', ss.move_cursor_down, desc = 'Move to Down Plane' },
					{ '<C-k>', ss.move_cursor_up, desc = 'Move to Up Plane' },
					{ '<C-l>', ss.move_cursor_right, desc = 'Move to Rigth Plane' },
					{
						'<C-bs>',
						ss.move_cursor_previous,
						desc = 'Move to Previous Plane',
					},
				},
			})
		end,
	},
}
