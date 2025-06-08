-- Lazy Plugin Manager {{{

-- Bootstrap Lazy.nvim plugin manager https://github.com/folke/lazy.nvim#-installation
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
   vim.fn.system {
      'git',
      'clone',
      '--filter=blob:none',
      'https://github.com/folke/lazy.nvim.git',
      '--branch=stable',
      lazypath,
   }
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

-- }}}

vim.g.mapleader = ' '
vim.g.maplocalleader = ','
vim.loader.enable()

_G.autocmd = vim.api.nvim_create_autocmd
_G.augroup = vim.api.nvim_create_augroup

-------------------------------------------------------------------------------
-- Lazy Setup

require('lazy').setup('plugins', {
   defaults = { lazy = true },
   checker = { enabled = true },
   diff = { cmd = 'diffview.nvim' },
   git = { timeot = 60 }, -- 1 min timeout for tasks
   ui = { border = 'rounded' },
})

-------------------------------------------------------------------------------
-- Configs

if vim.g.neovide then
   require 'core.neovide'
end

require 'core.options'
require 'core.keymaps'
require 'core.autocmds'
