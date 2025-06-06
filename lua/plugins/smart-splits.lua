---@type LazyPluginSpec
return {
   'mrjones2014/smart-splits.nvim',
   build = './kitty/install-kittens.bash',
   event = 'VeryLazy',
   config = function(_, opts)
      local ss = require('smart-splits')
      ss.setup(opts)
      require('which-key').add({
         { -- Buffer groub
            { '<leader>bh', ss.swap_buf_left, desc = 'Swap Left' },
            { '<leader>bj', ss.swap_buf_down, desc = 'Swap Down' },
            { '<leader>bk', ss.swap_buf_up, desc = 'Swap Up' },
            { '<leader>bl', ss.swap_buf_right, desc = 'Swap Right' },
         },
         { -- resizing splits
            { '<A-h>', ss.resize_left, desc = 'Resize Left' },
            { '<A-j>', ss.resize_down, desc = 'Resize Down' },
            { '<A-k>', ss.resize_up, desc = 'Resize Up' },
            { '<A-l>', ss.resize_right, desc = 'Resize Right' },
         },
         { -- moving between splits
            { '<C-h>', ss.move_cursor_left, desc = 'Move Left' },
            { '<C-j>', ss.move_cursor_down, desc = 'Move Down' },
            { '<C-k>', ss.move_cursor_up, desc = 'Move Up' },
            { '<C-l>', ss.move_cursor_right, desc = 'Move Rigth' },
            { '<C-bs>', ss.move_cursor_previous, desc = 'Move Previous' },
         },
      })
   end,
}
