---@type LazyPluginSpec[]
return {
	{
		'nvim-telescope/telescope.nvim',
		event = 'VimEnter',
		dependencies = {
			{ 'nvim-lua/plenary.nvim' },
			{ 'nvim-tree/nvim-web-devicons' },
			{
				'nvim-telescope/telescope-fzf-native.nvim',
				build = 'make',
				cond = function()
					return vim.fn.executable('make') == 1
				end,
			},
			{ 'nvim-telescope/telescope-ui-select.nvim' },
			{ 'jvgrootveld/telescope-zoxide', config = true },
			{ 'nvim-telescope/telescope-file-browser.nvim' },
			{
				'CsiPA0723/telescope-task-runner.nvim',
				dir = '/home/csipa/Personal/telescope-task-runner.nvim',
				dependencies = { 'CsiPA0723/task-runner.nvim' },
				config = true,
			},
		},
		config = function()
			require('telescope').setup({
				extensions = {
					['ui-select'] = {
						require('telescope.themes').get_dropdown(),
					},
					file_browser = {
						hijack_netrw = false,
					},
				},
			})

			pcall(require('telescope').load_extension, 'fzf')
			pcall(require('telescope').load_extension, 'ui-select')
			pcall(require('telescope').load_extension, 'notify')
			pcall(require('telescope').load_extension, 'zoxide')
			pcall(require('telescope').load_extension, 'scope')
			pcall(require('telescope').load_extension, 'file_browser')
			pcall(require('telescope').load_extension, 'licenses')
			pcall(require('telescope').load_extension, 'task_runner')
		end,
	},
}
