return {
	{
		'nvim-lualine/lualine.nvim',
		dependencies = { 'nvim-tree/nvim-web-devicons' },
		opts = {
			options = { theme = 'catppuccin' },
			sections = {
				lualine_a = {
					{
						'mode',
						fmt = function(str)
							return str:sub(1, 1)
						end,
					},
				},
				lualine_x = {
					function()
						local ok, pomo = pcall(require, 'pomo')
						if not ok then
							return ''
						end

						local timer = pomo.get_first_to_finish()
						if timer == nil then
							return ''
						end

						return '󰄉 ' .. tostring(timer)
					end,
					'encoding',
					'fileformat',
					'filetype',
				},
			},
			extensions = {
				'fzf',
				'lazy',
				'mason',
				'neo-tree',
				'nvim-dap-ui',
				'trouble',
				'toggleterm',
			},
		},
	},
}
