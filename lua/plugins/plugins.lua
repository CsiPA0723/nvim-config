---@type LazyPluginSpec[]
return {
	{ 'neolooong/whichpy.nvim', ft = 'python', config = true },
	{ 'nanotee/zoxide.vim', lazy = true, cmd = 'Z' },
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
		ft = 'yaml',
		dependencies = 'nvim-treesitter/nvim-treesitter',
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
		lazy = true,
		opts = { vscode_rest_client_environmentvars = true },
	},
	{
		'OXY2DEV/helpview.nvim',
		lazy = true,
		ft = 'help',
		dependencies = { 'nvim-treesitter/nvim-treesitter' },
	},
	{
		'fabridamicelli/cronex.nvim',
		cmd = { 'CronExplainedDisable', 'CronExplainedEnable' },
		lazy = true,
		config = true,
	},
	{
		'nvim-zh/colorful-winsep.nvim',
		config = true,
		event = 'WinLeave',
	},
	--[[ {
		'CsiPA0723/task-runner.nvim',
		dir = '/home/csipa/Personal/task-runner.nvim',
		dependencies = { 'nvim-lua/plenary.nvim' },
		lazy = true,
		cmd = { 'Tasks' },
		opts = {},
	}, ]]
}
