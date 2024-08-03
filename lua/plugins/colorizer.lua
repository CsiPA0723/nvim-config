---@type LazyPluginSpec[]
return {
	{
		'norcalli/nvim-colorizer.lua',
		config = function()
			require('colorizer').setup({
				'css',
				'scss',
				'javascript',
				'typescript',
				'angular',
				'html',
				'angular.html',
				'htmlangular',
			}, {
				RRGGBBAA = true,
				rgb_fn = true,
				hsl_fn = true,
				css = true,
				css_fn = true,
			})
		end,
	},
}
