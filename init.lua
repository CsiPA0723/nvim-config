-------------------------------------------------------------------------------
-- Lazy Plugin Manager

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
   local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
   local out = vim.fn.system({
      'git',
      'clone',
      '--filter=blob:none',
      '--branch=stable',
      lazyrepo,
      lazypath,
   })
   if vim.v.shell_error ~= 0 then
      vim.api.nvim_echo({
         { 'Failed to clone lazy.nvim:\n', 'ErrorMsg' },
         { out, 'WarningMsg' },
         { '\nPress any key to exit...' },
      }, true, {})
      vim.fn.getchar()
      os.exit(1)
   end
end
vim.opt.rtp:prepend(lazypath)

require('core.options')

if vim.g.neovide then
   require('core.neovide')
end

_G.autocmd = vim.api.nvim_create_autocmd
_G.augroup = vim.api.nvim_create_augroup

-------------------------------------------------------------------------------
-- Lazy Setup

require('lazy').setup('plugins', {
   defaults = { lazy = true },
   checker = { enabled = true, notify = false },
   diff = { cmd = 'diffview.nvim' },
   install = { colorscheme = { 'catppuccin' } },
   git = { timeot = 60 }, -- 1 min timeout for tasks
   ui = { border = vim.o.winborder:lower() or 'rounded' },
})

-------------------------------------------------------------------------------
-- Configs

require('core.keymaps')
require('core.autocmds')
require('core.snippets')
