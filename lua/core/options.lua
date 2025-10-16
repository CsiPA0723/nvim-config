vim.g.mapleader = ' '
vim.g.maplocalleader = ','
vim.o.winborder = 'rounded'
vim.o.pumborder = 'rounded'

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.diffopt =
   'internal,filler,closeoff,indent-heuristic,linematch:60,algorithm:histogram'

vim.o.ssop =
   'buffers,curdir,folds,help,globals,tabpages,winpos,winsize,terminal'

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

vim.o.virtualedit = 'block'

vim.o.timeoutlen = 500

vim.diagnostic.config({
   on_jump = { float = true },
   signs = {
      priority = 9999,
      severity = {
         min = vim.diagnostic.severity.WARN,
         max = vim.diagnostic.severity.ERROR,
      },
   },
   underline = {
      severity = {
         min = vim.diagnostic.severity.HINT,
         max = vim.diagnostic.severity.ERROR,
      },
   },
   update_in_insert = false,
   virtual_lines = false,
   virtual_text = {
      current_line = true,
      severity = {
         min = vim.diagnostic.severity.ERROR,
         max = vim.diagnostic.severity.ERROR,
      },
   },
})

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.o.equalalways = false

vim.opt.fillchars:append({
   eob = '~',
   fold = ' ',
   foldopen = '',
   foldsep = ' ',
   foldclose = '',
})

vim.opt.inccommand = 'split'

vim.g.python3_host_prog = vim.fn.stdpath('config') .. '/.venv/bin/python3'
vim.g.loaded_perl_provider = 0

vim.filetype.add({
   pattern = {
      ['zprofile'] = 'zsh',
      ['.prettyphp'] = 'json',
   },
})
