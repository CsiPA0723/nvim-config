---@type LazyPluginSpec[]
return {
	{ 'saghen/blink.compat', version = '*', lazy = true, config = true },
	{ 'xzbdmw/colorful-menu.nvim', lazy = true, config = true },
	{
		'saghen/blink.cmp',
		event = 'InsertEnter',
		build = 'cargo build --release',
		dependencies = {
			{
				'L3MON4D3/LuaSnip',
				version = '2.*',
				build = 'make install_jsregexp',
				dependencies = {
					{
						'rafamadriz/friendly-snippets',
						config = function()
							require('luasnip.loaders.from_vscode').lazy_load()
						end,
					},
				},
			},
			{
				'supermaven-inc/supermaven-nvim',
				event = 'InsertEnter',
				cmd = { 'SupermavenUseFree', 'SupermavenUsePro' },
				lazy = true,
				opts = {
					keymaps = { accept_suggestion = nil },
					disable_inline_completion = true,
				},
			},
		},
		---@type blink.cmp.Config
		opts = {
			appearance = { nerd_font_variant = 'normal' },
			keymap = {
				preset = 'none',
				['<C-n>'] = { 'select_next', 'fallback' },
				['<C-p>'] = { 'select_prev', 'fallback' },
				['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
				['<C-f>'] = { 'scroll_documentation_down', 'fallback' },
				['<C-y>'] = { 'select_and_accept' },
				['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
				['<C-l>'] = { 'snippet_forward', 'fallback' },
				['<C-h>'] = { 'snippet_backward', 'fallback' },
			},
			completion = {
				menu = {
					draw = {
						-- We don't need label_description now because label and label_description are already
						-- conbined together in label by colorful-menu.nvim.
						columns = { { 'kind_icon' }, { 'label', gap = 1 } },
						components = {
							-- HACK: for adding custom icon for supermaven | TEMP
							kind_icon = {
								text = function(ctx)
									if ctx.source_name == 'supermaven' then
										return '' .. ctx.icon_gap
									end
									return ctx.kind_icon .. ctx.icon_gap
								end,
							},
							label = {
								text = function(ctx)
									return require('colorful-menu').blink_components_text(ctx)
								end,
								highlight = function(ctx)
									return require('colorful-menu').blink_components_highlight(
										ctx
									)
								end,
							},
						},
					},
				},
			},
			snippets = { preset = 'luasnip' },
			sources = {
				default = { 'lsp', 'snippets', 'path', 'buffer', 'supermaven' },
				providers = {
					supermaven = {
						name = 'supermaven',
						module = 'blink.compat.source',
						score_offset = 3,
						async = true,
					},
				},
			},
		},
		opts_extend = { 'sources.default' },
	},
}