return {
	{
		'goolord/alpha-nvim',
		dependencies = { 'nvim-tree/nvim-web-devicons' },
		config = function()
			require 'alpha'.setup(require 'alpha.themes.startify'.config)

			local wk = require 'which-key'

			wk.register({
				h = { '<cmd>Alpha<cr>', 'Open Das[h]board' },
			}, { mode = 'n', prefix = '<leader>' })
		end,
	},
}
