local wk = require('which-key')

vim.o.conceallevel = 2
vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.shiftwidth = 2

wk.add({
	cond = function()
		return vim.bo.filetype == 'markdown'
	end,
	buffer = true,
	{
		'<leader>t',
		function()
			local newline = vim.api.nvim_get_current_line():gsub('%[([x/ -])%]', {
				['x'] = '[-]',
				['-'] = '[ ]',
				[' '] = '[x]',
			})
			vim.api.nvim_set_current_line(newline)
		end,
		desc = 'Toggle checkmark',
	},
})
