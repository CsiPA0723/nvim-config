local kulala = require('kulala')
local wk = require('which-key')

wk.add({
	cond = function()
		return vim.bo.filetype == 'http'
	end,
	buffer = true,
	{ '[h', kulala.jump_prev, desc = 'Jumpt to previous HTTP request' },
	{ ']h', kulala.jump_next, desc = 'Jumpt to next HTTP request' },
	{ '<leader>r', kulala.run, desc = 'Run HTTP request (kulala)' },
})
