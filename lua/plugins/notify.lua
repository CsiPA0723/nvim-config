---@type LazyPluginSpec
return {
   'j-hui/fidget.nvim',
   priority = 999,
   lazy = false,
   opts = {
      notification = {
         filter = vim.log.levels.INFO,
         override_vim_notify = true,
      },
   },
   config = function(_, opts)
      require('fidget').setup(opts)
      local notif = require('fidget.notification')
      notif.set_config('session', {
         name = 'Session',
         icon = '❰❰',
         ttl = 8,
      }, true)
   end,
}
