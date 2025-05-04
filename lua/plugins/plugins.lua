---@type LazyPluginSpec[]
return {
	-- Shared dependencies {{{
	{ 'nvim-treesitter/nvim-treesitter', optional = true },
	{ 'nvim-tree/nvim-web-devicons', optional = true },
	{ 'nvim-lua/plenary.nvim', optional = true },
	-- }}}
	{ 'neolooong/whichpy.nvim', ft = 'python', config = true },
	{ 'fladson/vim-kitty', ft = 'kitty' },
	{ 'folke/persistence.nvim', event = 'BufReadPre', opts = { need = 2 } },
	{ 'ThePrimeagen/vim-be-good', cmd = 'VimBeGood' },
	{
		'folke/which-key.nvim',
		event = 'VeryLazy',
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
		ft = 'yaml',
		dependencies = 'nvim-treesitter/nvim-treesitter',
	},
	{
		'folke/trouble.nvim',
		dependencies = 'nvim-tree/nvim-web-devicons',
		cmd = 'Trouble',
		config = true,
	},
	{
		'mistweaverco/kulala.nvim',
		ft = { 'http', 'rest' },
		opts = { vscode_rest_client_environmentvars = true },
	},
	{
		'OXY2DEV/patterns.nvim',
		dependencies = 'nvim-treesitter/nvim-treesitter',
		cmd = 'Patterns',
	},
	{
		'OXY2DEV/helpview.nvim',
		ft = 'help',
		dependencies = 'nvim-treesitter/nvim-treesitter',
	},
	{
		'nvim-zh/colorful-winsep.nvim',
		event = 'WinLeave',
		config = true,
	},
	{
		'CsiPA0723/task-runner.nvim',
		dir = '/home/csipa/Personal/task-runner.nvim',
		dependencies = { 'nvim-lua/plenary.nvim', 'folke/snacks.nvim' },
		event = 'VeryLazy',
		---@type TaskRunner.config
		opts = {
			tasks_dir = '/home/csipa/Personal/task-runner.nvim/examples',
		},
	},
}
