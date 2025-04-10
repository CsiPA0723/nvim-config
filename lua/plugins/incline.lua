---@type LazyPluginSpec[]
return {
	{
		'b0o/incline.nvim',
		event = 'VeryLazy',
		opts = {
			hide = { cursorline = true, only_win = 'count_ignored' },
			window = {
				padding = 0,
				margin = { vertical = 0, horizontal = 0 },
				placement = { vertical = 'top' },
				overlap = {
					borders = true,
					tabline = false,
					winbar = true,
					statusline = true,
				},
			},
		},
		config = function(_, opts)
			local devicons = require 'nvim-web-devicons'
			local palette = require 'catppuccin.palettes'.get_palette('macchiato')

			opts.render = function(props)
				local filename =
					vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ':t')
				if filename == '' then
					filename = ' '
				end
				local ft_icon, ft_color = devicons.get_icon_color(filename)
				local modified = vim.bo[props.buf].modified
				local readonly = vim.bo[props.buf].readonly
				return {
					vim.g.neovide and '' or {
						'',
						guifg = palette.surface0,
						guibg = palette.base,
					},
					ft_icon and { ' ' .. ft_icon .. ' ', guifg = ft_color } or '',
					' ',
					filename,
					(modified or readonly) and {
						' ',
						modified and '[+]' or readonly and '[-]' or '',
					} or '',
					' ',
					vim.g.neovide and '' or {
						'',
						guifg = palette.surface0,
						guibg = palette.base,
					},
					guifg = palette.text,
					guibg = palette.surface0,
				}
			end

			require('incline').setup(opts)
		end,
	},
}
