local notify_group = 'hardtime'

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
         vim.notify(text, vim.log.levels.WARN, { group = notify_group })
      end,
   },
   config = function(_, opts)
      require('fidget.notification').set_config(notify_group, {
         name = 'Hardtime',
         icon = ' ',
         ttl = 6,
         skip_history = true,
      }, true)
      local hardtime = require('hardtime')
      hardtime.setup(opts)

      Snacks.toggle
         .new({
            name = 'Hardtime',
            id = 'hardtime',
            notify = false,
            which_key = true,
            get = function()
               return hardtime.is_plugin_enabled
            end,
            set = function()
               hardtime.toggle()
               vim.notify(
                  (hardtime.is_plugin_enabled and 'Enabled' or 'Disabled')
                     .. ' plugin!',
                  hardtime.is_plugin_enabled and vim.log.levels.INFO
                     or vim.log.levels.WARN,
                  { group = notify_group, history = false }
               )
            end,
         })
         :map('<leader>H')
   end,
}
