---@type LazyPluginSpec[]
return {
	{
		'catppuccin/nvim',
		name = 'catppuccin',
		priority = 1000,
		opts = {
			flavour = 'macchiato',
			show_end_of_buffer = true, -- shows the '~' characters after the end of buffers
			term_colors = true, -- sets terminal colors (e.g. `g:terminal_color_0`)
			dim_inactive = {
				enabled = true, -- dims the background color of inactive window
				shade = 'dark',
				percentage = 0.15, -- percentage of the shade to apply to the inactive window
			},
			integrations = {
				alpha = true,
				cmp = true,
				dap = true,
				dap_ui = true,
				diffview = true,
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
				neogit = true,
				notify = true,
				markdown = true,
				mason = true,
				lsp_trouble = true,
				treesitter = true,
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
			sign('DapBreakpointCondition', {
				text = '●',
				texthl = 'DapBreakpointCondition',
				linehl = '',
				numhl = '',
			})
			sign(
				'DapLogPoint',
				{ text = '◆', texthl = 'DapLogPoint', linehl = '', numhl = '' }
			)

			vim.cmd.colorscheme('catppuccin')
		end,
	},
}
