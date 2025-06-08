local notify_opts = { group = 'hardtime' }

---@type LazyPluginSpec
return {
   'm4xshen/hardtime.nvim',
   event = 'VeryLazy',
   dependencies = { 'MunifTanjim/nui.nvim' },
   opts = {
      max_count = 5,
      disable_mouse = false,
      disabled_filetypes = { 'LuaPatterns', 'RegexPatterns' },
      callback = function(text)
         vim.notify(text, vim.log.levels.WARN, notify_opts)
      end,
   },
   config = function(_, opts)
      require('fidget.notification').set_config(notify_opts.group, {
         name = 'Hardtime',
         icon = ' ',
         ttl = 6,
         skip_history = true,
      }, true)
      require('hardtime').setup(opts)
   end,
}
