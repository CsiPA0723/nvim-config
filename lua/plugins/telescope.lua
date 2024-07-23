return {
	{
		'nvim-telescope/telescope.nvim',
		event = 'VimEnter',
		dependencies = {
			{ 'nvim-lua/plenary.nvim' },
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
			{ 'nvim-tree/nvim-web-devicons' },
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
			pcall(require('telescope').load_extension, 'pomodori')
		end,
	},
}
