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
		opts = {
			source_selector = { winbar = true },
			close_if_last_window = true,
		},
		config = function(opts)
			require('neo-tree').setup(opts)

			local wk = require('which-key')

			wk.register({
				t = { '<cmd>Neotree toggle<CR>', 'Neo-[T]ree' },
			}, { noremap = true, prefix = '<leader>' })
		end,
	},
}
