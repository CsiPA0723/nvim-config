local function showFileInWin()
	local wins = vim.fn.filter(vim.api.nvim_tabpage_list_wins(0), function(_, v)
		local cfg = vim.api.nvim_win_get_config(v)
		return cfg.relative == '' or cfg.external
	end)

	return #wins > 1
end

---@type LazyPluginSpec[]
return {
	{
		'nvim-lualine/lualine.nvim',
		dependencies = { 'nvim-tree/nvim-web-devicons' },
		opts = {
			options = {
				theme = 'catppuccin',
				icons_enabled = true,
				globalstatus = true,
			},
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
					'encoding',
					'fileformat',
					'filetype',
				},
			},
			tabline = {
				lualine_a = { { 'tabs', mode = 2, max_length = vim.o.columns } },
			},
			winbar = {
				lualine_c = { { 'filename', cond = showFileInWin } },
			},
			inactive_winbar = {
				lualine_c = { { 'filename', cond = showFileInWin } },
			},
			extensions = {
				'fzf',
				'lazy',
				'mason',
				'nvim-dap-ui',
				'oil',
				'quickfix',
				'toggleterm',
				'trouble',
			},
		},
		config = function(_, opts)
			require('lualine').setup(opts)
			vim.o.showtabline = 1
		end,
	},
}
