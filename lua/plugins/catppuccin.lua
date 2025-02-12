---@type LazyPluginSpec[]
return {
	{
		'catppuccin/nvim',
		name = 'catppuccin',
		lazy = false,
		priority = 500,
		---@type CatppuccinOptions
		opts = {
			compile_path = vim.fn.stdpath 'cache' .. '/catppuccin',
			kitty = true,
			flavour = 'macchiato',
			show_end_of_buffer = true, -- shows the '~' characters after the end of buffers
			term_colors = true, -- sets terminal colors (e.g. `g:terminal_color_0`)
			dim_inactive = {
				enabled = true, -- dims the background color of inactive window
				shade = 'dark',
				percentage = 0.15, -- percentage of the shade to apply to the inactive window
			},
			integrations = {
				blink_cmp = true,
				colorful_winsep = {
					enabled = true,
					color = 'red',
				},
				dap = true,
				dap_ui = true,
				diffview = true,
				fidget = true,
				gitsigns = true,
				indent_blankline = {
					enabled = true,
					scope_color = 'lavender',
					colored_indent_levels = true,
				},
				--Lualine.nvim #enabled
				lsp_trouble = true,
				markdown = true,
				mason = true,
				mini = {
					enabled = true,
					indentscope_color = 'lavender',
				},
				neogit = true,
				noice = true,
				notify = true,
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
				render_markdown = true,
				snacks = true,
				treesitter = true,
				ufo = true,
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
