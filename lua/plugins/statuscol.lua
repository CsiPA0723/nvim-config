return {
	{
		'luukvbaal/statuscol.nvim',
		config = function()
			local builtin = require('statuscol.builtin')
			require('statuscol').setup({
				ft_ignore = {
					'help',
					'alpha',
					'dashboard',
					'neo-tree',
					'Trouble',
					'lazy',
					'mason',
				},
				relculright = true,
				segments = {
					{ text = { builtin.foldfunc }, click = 'v:lua.ScFa' },
					{ text = { '%s' }, click = 'v:lua.ScSa' },
					{ text = { builtin.lnumfunc, ' ' }, click = 'v:lua.ScLa' },
				},
			})
		end,
	},
}
