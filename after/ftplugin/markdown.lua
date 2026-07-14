local wk = require('which-key')

vim.bo.tabstop = 2
vim.bo.softtabstop = 2
vim.bo.shiftwidth = 2

wk.add({
   cond = function()
      return vim.bo.filetype == 'markdown'
   end,
   buffer = true,
   mode = { 'n', 'v' },
   { '<leader>t', group = 'Checkmate', icon = ' ' },
   ---@see chekmate.Config at `/lua/plugins/theme.lua` for keympas
})
