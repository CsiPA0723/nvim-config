---@type LazyPluginSpec
return {
	'mistweaverco/kulala.nvim',
	ft = { 'http', 'rest' },
	opts = { vscode_rest_client_environmentvars = true },
	init = function(_)
		vim.filetype.add({
			extension = {
				http = 'http',
			},
		})
	end,
	config = function(_, opts)
		require('which-key').add({
			cond = function()
				return vim.bo.filetype == 'http' or vim.bo.filetype == 'rest'
			end,
			buffer = true,
			{
				'[h',
				require('kulala').jump_prev,
				desc = 'Jumpt to prev HTTP request',
			},
			{
				']h',
				require('kulala').jump_next,
				desc = 'Jumpt to next HTTP request',
			},
			{
				'<leader>r',
				require('kulala').run,
				desc = 'Run HTTP request (kulala)',
			},
		})
		require('kulala').setup(opts)
	end,
}
