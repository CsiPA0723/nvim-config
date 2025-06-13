local configpath = vim.fn.stdpath('config')

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.diffopt =
   'internal,filler,closeoff,indent-heuristic,linematch:60,algorithm:histogram'

vim.o.ssop = 'buffers,curdir,folds,help,tabpages,winsize,terminal'

vim.opt.wrap = false

vim.opt.undofile = true

vim.opt.hlsearch = true
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 10
vim.opt.signcolumn = 'yes'
vim.opt.isfname:append('@-@')

vim.opt.updatetime = 50

vim.opt.colorcolumn = '80'

vim.opt.mouse = ''
vim.opt.showmode = false
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.o.timeoutlen = 500

vim.diagnostic.config({ on_jump = { float = true } })

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.o.equalalways = false

vim.opt.fillchars:append {
   eob = '~',
   fold = ' ',
   foldopen = '',
   foldsep = ' ',
   foldclose = '',
}

vim.opt.inccommand = 'split'

vim.g.python3_host_prog = configpath .. '/.venv/bin/python3'
vim.g.loaded_perl_provider = 0

vim.filetype.add({
   pattern = {
      ['zprofile'] = 'zsh',
      ['.prettyphp'] = 'json',
   },
})
