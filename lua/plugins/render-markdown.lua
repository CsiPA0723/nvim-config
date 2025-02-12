---@type LazyPluginSpec[]
return {
	{
		'MeanderingProgrammer/render-markdown.nvim',
		dependencies = {
			'nvim-treesitter/nvim-treesitter',
			'nvim-tree/nvim-web-devicons',
		},
		ft = { 'markdown', 'quarto' },
		---@module 'render-markdown'
		---@type render.md.UserConfig
		opts = {
			render_modes = { 'n', 'c', 't' },
		},
	},
}
