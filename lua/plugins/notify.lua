---@type LazyPluginSpec
return {
   'j-hui/fidget.nvim',
   priority = 1000,
   lazy = false,
   opts = { notification = { override_vim_notify = true } },
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
