return {
	{
		'catppuccin/nvim',
		name = 'catppuccin',
		priority = 1000,
		opts = {
			flavour = 'macchiato',
			integrations = {
				aerial = true,
				dashboard = true,
				gitsigns = true,
				indent_blankline = {
					enabled = true,
					scope_color = 'lavender',
					colored_indent_levels = true,
				},
				ufo = true,
				neotree = true,
				notify = true,
				lsp_trouble = true,
				treesitter = true,
				rainbow_delimiters = true,
				telescope = { enabled = true },
				which_key = true,
			},
		},
		config = function(_, opts)
			require('catppuccin').setup(opts)

			vim.cmd.colorscheme('catppuccin')
		end,
	},
}
