return {
	{
		'anuvyklack/windows.nvim',
		dependencies = {
			'anuvyklack/middleclass',
			'anuvyklack/animation.nvim',
		},
		event = 'VeryLazy',
		config = function()
			vim.o.winwidth = 10
			vim.o.winminwidth = 10
			vim.o.equalalways = false

			local wk = require('which-key')

			wk.register({
				z = { '<cmd>WindowsMaximize<CR>', 'Maximize' },
				['_'] = { '<cmd>WindowsMaximizeVertically<CR>', 'Max out the hight' },
				['|'] = { '<cmd>WindowsMaximizeHorizontall<CR>', 'Max out the width' },
				['='] = { '<cmd>WindowsEqualize<CR>', 'Equal high and wide' },
			}, { mode = 'n', prefix = '<C-w>' })

			require('windows').setup()
		end,
	},
}
