local notify_group = 'hardtime'

---@type LazyPluginSpec[]
return {
   { 'ThePrimeagen/vim-be-good', cmd = 'VimBeGood' },
   {
      'saxon1964/neovim-tips',
      version = '*', -- Only update on tagged releases
      dependencies = {
         'MunifTanjim/nui.nvim',
         'MeanderingProgrammer/render-markdown.nvim',
      },
      opts = {
         -- OPTIONAL: Location of user defined tips (default value shown below)
         user_file = vim.fn.stdpath('data') .. '/neovim_tips/user_tips.md',
         -- OPTIONAL: Prefix for user tips to avoid conflicts (default: "[User] ")
         user_tip_prefix = '[User] ',
         -- OPTIONAL: Show warnings when user tips conflict with builtin (default: true)
         warn_on_conflicts = true,
         -- OPTIONAL: Daily tip mode (default: 1)
         -- 0 = off, 1 = once per day, 2 = every startup
         daily_tip = 0,
      },
      cmd = {
         'NeovimTips',
         'NeovimTipsAdd',
         'NeovimTipsEdit',
         'NeovimTipsPdf',
         'NeovimTipsRandom',
      },
   },
   {
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
   },
}
