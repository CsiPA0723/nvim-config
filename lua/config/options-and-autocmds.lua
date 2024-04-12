vim.signcolumn = 'yes'
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = 'a'
vim.opt.showmode = false
vim.opt.breakindent = true
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.updatetime = 250
vim.o.timeoutlen = 500
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.list = true
vim.opt.fillchars:append {
	eob = '~',
	fold = ' ',
	foldopen = '',
	foldsep = ' ',
	foldclose = '',
}
vim.opt.listchars:append { tab = '▎ ', trail = '·', nbsp = '␣' }
vim.opt.inccommand = 'split'
vim.opt.cursorline = true
vim.opt.scrolloff = 10
vim.opt.hlsearch = true
vim.opt.termguicolors = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.colorcolumn = '80'

if jit.os == 'Windows' then
	vim.opt.shell = 'pwsh'
	vim.opt.shellcmdflag =
		'-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;'
	vim.opt.shellredir = '-RedirectStandardOutput %s -NoNewWindow -Wait'
	vim.opt.shellpipe = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
	vim.opt.shellquote = ''
	vim.opt.shellxquote = ''
	-- NOTE: It could breake some plugins, handle with care
	vim.opt.shellslash = true
end

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
