-- HACK: For a deprecetated functions {{{

-- HACK: Fixing unpack sometimes not working correctly
table.unpack = table.unpack or unpack -- 5.1 compatibility

---@param tbl table
---@diagnostic disable-next-line: duplicate-set-field
vim.tbl_flatten = function(tbl)
	return vim.iter(tbl):flatten():totable()
end

---@param tbl table
---@diagnostic disable-next-line: duplicate-set-field
vim.tbl_add_reverse_lookup = function(tbl)
	for k, v in pairs(tbl) do
		tbl[v] = k
	end
end

-- }}}

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
	checker = { enabled = true, notify = true },
	diff = { cmd = 'diffview.nvim' },
	git = { timeot = 60 }, -- 1 min timeout for tasks
	ui = { border = 'rounded' },
})

-------------------------------------------------------------------------------
-- Configs

if vim.g.neovide then
	require 'csipa.neovide'
end

require 'csipa.options'
require 'csipa.keymaps'
require 'csipa.autocmds'
