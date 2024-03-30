return {
	{
		'nvim-neo-tree/neo-tree.nvim',
		branch = 'v3.x',
		dependencies = {
			'nvim-lua/plenary.nvim',
			'nvim-tree/nvim-web-devicons',
			'MunifTanjim/nui.nvim',
			'3rd/image.nvim',
		},
		config = function()
			require('neo-tree').setup()

			local wk = require('which-key')

			wk.register({
				n = {
					name = '[N]eo-Tree',
					n = { '<cmd>Neotree toggle position=float<cr>', 'Toggle [N]eo-Tree' },
					l = { '<cmd>Neotree toggle position=left<cr>', 'Open [L]eft' },
					c = { '<cmd>Neotree current<cr>', 'Open [C]urrent' },
				},
			}, { noremap = true, prefix = '<leader>' })
		end,
	},
}
