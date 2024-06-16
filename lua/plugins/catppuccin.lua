return {
	{
		'catppuccin/nvim',
		name = 'catppuccin',
		priority = 1000,
		opts = {
			flavour = 'macchiato',
			integrations = {
				alpha = true,
				barbecue = {
					dim_dirname = true, -- directory name is dimmed by default
					bold_basename = true,
					dim_context = false,
					alt_background = false,
				},
				cmp = true,
				dap = true,
				dap_ui = true,
				gitsigns = true,
				indent_blankline = {
					enabled = true,
					scope_color = 'lavender',
					colored_indent_levels = true,
				},
				ufo = true,
				native_lsp = {
					enabled = true,
					virtual_text = {
						errors = { 'italic' },
						hints = { 'italic' },
						warnings = { 'italic' },
						information = { 'italic' },
					},
					underlines = {
						errors = { 'underline' },
						hints = { 'underline' },
						warnings = { 'underline' },
						information = { 'underline' },
					},
					inlay_hints = {
						background = true,
					},
				},
				neotree = true,
				notify = true,
				markdown = true,
				mason = true,
				mini = {
					enabled = true,
					indentscope_color = 'lavender',
				},
				lsp_trouble = true,
				treesitter = true,
				rainbow_delimiters = true,
				telescope = { enabled = true },
				which_key = true,
			},
		},
		config = function(_, opts)
			require('catppuccin').setup(opts)

			local sign = vim.fn.sign_define

			sign(
				'DapBreakpoint',
				{ text = '●', texthl = 'DapBreakpoint', linehl = '', numhl = '' }
			)
			sign(
				'DapBreakpointCondition',
				{
					text = '●',
					texthl = 'DapBreakpointCondition',
					linehl = '',
					numhl = '',
				}
			)
			sign(
				'DapLogPoint',
				{ text = '◆', texthl = 'DapLogPoint', linehl = '', numhl = '' }
			)

			vim.cmd.colorscheme('catppuccin')
		end,
	},
}
