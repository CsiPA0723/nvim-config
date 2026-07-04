local ipc = require('csipa.protocols.ipc')
local wk = require('which-key')

wk.add({
   { '<leader>r', group = 'LRC Edit', icon = ' ' },
   {
      '<leader>rc',
      function()
         ipc.connect()
      end,
      desc = 'IPC: Open Connection',
   },
   {
      '<leader>rC',
      function()
         ipc.close()
      end,
      desc = 'IPC: Close Connection',
   },
   {
      '<leader>rt',
      function()
         ipc.get_playback_time()
      end,
      desc = 'IPC: Get Playback Time',
   },
   {
      '<leader>rs',
      function()
         ipc.spawn_mpv()
      end,
      desc = 'IPC: Spawn mpv',
   },
   {
      '<leader>rl',
      function()
         local path = vim.fn.expand('%:p:r') .. '.flac'
         ipc.load_music(path)
      end,
      desc = 'IPC: Spawn mpv',
   },
   mode = { 'n' },
   buffer = true,
})
