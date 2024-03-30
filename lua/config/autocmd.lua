local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

autocmd('TextYankPost', {
	desc = 'Highlight when yanking (copying) text',
	group = augroup('csipa-highlight-yank', { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

autocmd('FocusGained', {
	desc = 'Notify when coming back to a file that does not exist anymore',
	group = augroup('csipa-alert-file-exist', { clear = true }),
	callback = function()
		local fileExists = vim.loop.fs_stat(vim.fn.expand('%')) ~= nil
		local specialBuffer = vim.bo.buftype ~= ''
		if not fileExists and not specialBuffer then
			vim.notify(
				'File does not exist anymore.',
				vim.log.levels.WARN,
				{ timeout = 20000 }
			)
		end
	end,
})
