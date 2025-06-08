local wk = require('which-key')

vim.bo.tabstop = 2
vim.bo.softtabstop = 2
vim.bo.shiftwidth = 2

wk.add({
   cond = function()
      return vim.bo.filetype == 'markdown'
   end,
   buffer = true,
   {
      '<leader>x',
      function()
         local newline = vim.api.nvim_get_current_line():gsub('%[([x -])%]', {
            ['x'] = '[-]',
            ['-'] = '[ ]',
            [' '] = '[x]',
         })
         vim.api.nvim_set_current_line(newline)
      end,
      desc = 'Toggle checkmark',
   },
})
