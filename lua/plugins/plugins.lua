return {
	{
		'rcarriga/nvim-notify',
		opts = { fps = 60, render = 'default', stages = 'slide' },
		config = function(_, opts)
			require('notify').setup(opts)
			vim.notify = require('notify')
		end,
	},
	{ 'folke/which-key.nvim' },
	{
		'akinsho/toggleterm.nvim',
		version = '*',
		opts = { open_mapping = '<C-ö>' },
	},
	{ 'nanotee/zoxide.vim' },
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
		'folke/todo-comments.nvim',
		event = 'VimEnter',
		dependencies = { 'nvim-lua/plenary.nvim' },
		config = true,
	},
	{
		'folke/trouble.nvim',
		dependencies = { 'nvim-tree/nvim-web-devicons' },
		config = true,
	},
	{
		'anuvyklack/windows.nvim',
		dependencies = { 'anuvyklack/middleclass', 'anuvyklack/animation.nvim' },
		event = 'VeryLazy',
		config = true,
	},
	{
		'tris203/precognition.nvim',
		event = 'VeryLazy',
		opts = {
			startVisible = false,
			highlightColor = { link = 'Whitespace' },
		},
	},
	{
		'm4xshen/hardtime.nvim',
		dependencies = { 'MunifTanjim/nui.nvim', 'nvim-lua/plenary.nvim' },
		opts = {
			-- Add "oil" to the disabled_filetypes
			disabled_filetypes = { 'qf', 'netrw', 'NvimTree', 'lazy', 'mason', 'oil' },
			hints = {
				['k%^'] = {
					message = function()
						return 'Use - instead of k^' -- return the hint message you want to display
					end,
					length = 2, -- the length of actual key strokes that matches this pattern
				},
				['d[tTfF].i'] = { -- this matches d + {t/T/f/F} + {any character} + i
					message = function(keys) -- keys is a string of key strokes that matches the pattern
						return 'Use ' .. 'c' .. keys:sub(2, 3) .. ' instead of ' .. keys
						-- example: Use ct( instead of dt(i
					end,
					length = 4,
				},
				['[dcyvV][ia][%(%)]'] = {
					message = function(keys)
						return 'Use ' .. keys:sub(1, 2) .. 'b instead of ' .. keys
					end,
					length = 3,
				},
			},
		},
	},
}
