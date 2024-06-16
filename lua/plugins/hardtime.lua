return {
	{
		'm4xshen/hardtime.nvim',
		dependencies = { 'MunifTanjim/nui.nvim', 'nvim-lua/plenary.nvim' },
		opts = {
			max_count = 5,
			allow_different_key = true,
			disabled_filetypes = {
				'qf',
				'netrw',
				'NvimTree',
				'lazy',
				'mason',
				'oil',
				'alpha',
			},
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
