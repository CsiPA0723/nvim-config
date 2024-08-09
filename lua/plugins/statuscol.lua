---@type LazyPluginSpec[]
return {
	{
		'luukvbaal/statuscol.nvim',
		event = 'VeryLazy',
		config = function()
			local builtin = require('statuscol.builtin')
			require('statuscol').setup({
				ft_ignore = {
					'help',
					'alpha',
					'dashboard',
					'Trouble',
					'lazy',
					'mason',
					'Neogit*',
				},
				relculright = true,
				segments = {
					{ text = { builtin.foldfunc } },
					{ text = { '%s' } },
					{ text = { builtin.lnumfunc, ' ' } },
				},
			})
		end,
	},
}
