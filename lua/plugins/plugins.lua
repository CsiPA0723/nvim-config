---@type LazyPluginSpec[]
return {
	{ 'neolooong/whichpy.nvim', config = true },
	{ 'nanotee/zoxide.vim' },
	{
		'folke/which-key.nvim',
		---@class wk.Opts
		opts = { preset = 'modern', win = { no_overlap = false }, delay = 500 },
	},
	{
		'mistricky/codesnap.nvim',
		cmd = { 'CodeSnap', 'CodeSnapSave' },
		build = 'make build_generator',
	},
	{
		'cuducos/yaml.nvim',
		lazy = true,
		ft = { 'yaml' },
		dependencies = {
			'nvim-treesitter/nvim-treesitter',
			'nvim-telescope/telescope.nvim',
		},
	},
	{
		'folke/trouble.nvim',
		dependencies = { 'nvim-tree/nvim-web-devicons' },
		event = 'VeryLazy',
		config = true,
	},
	{
		'anuvyklack/windows.nvim',
		dependencies = { 'anuvyklack/middleclass', 'anuvyklack/animation.nvim' },
		event = 'VeryLazy',
		config = true,
	},
	{
		'mrjones2014/smart-splits.nvim',
		build = './kitty/install-kittens.bash',
		event = 'VeryLazy',
		config = true,
	},
	{
		'mistweaverco/kulala.nvim',
		opts = { vscode_rest_client_environmentvars = true },
	},
	{
		'OXY2DEV/helpview.nvim',
		lazy = false,
		dependencies = { 'nvim-treesitter/nvim-treesitter' },
	},
}
