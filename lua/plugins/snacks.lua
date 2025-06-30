local header_neovim = [[
███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝]]

local header_neovide = [[
███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗██████╗ ███████╗
████╗  ██║██╔════╝██╔═══██╗██║   ██║██║██╔══██╗██╔════╝
██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██║  ██║█████╗  
██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║  ██║██╔══╝  
██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██████╔╝███████╗
╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═════╝ ╚══════╝]]

---@type LazyPluginSpec
return {
   'folke/snacks.nvim',
   priority = 1000,
   lazy = false,
   ---@type snacks.Config
   opts = {
      bigfile = { enabled = true },
      explorer = { replace_netrw = false },
      input = { enabled = true },
      image = { enabled = true },
      statuscolumn = { enabled = true },
      gitbrowse = { enabled = true },
      picker = { enabled = true },
      lazygit = { enabled = true },
      dashboard = {
         width = 50,
         preset = {
            header = vim.g.neovide and header_neovide or header_neovim,
            keys = {
               {
                  icon = ' ',
                  key = 'e',
                  desc = 'New File',
                  action = ':ene | startinsert',
               },
               {
                  icon = ' ',
                  key = 'f',
                  desc = 'Find File',
                  action = function()
                     Snacks.dashboard.pick('files')
                  end,
               },
               {
                  icon = ' ',
                  key = 'z',
                  desc = 'Zoxide',
                  action = function()
                     Snacks.dashboard.pick('zoxide')
                  end,
               },

               {
                  icon = '󰒲 ',
                  key = 'L',
                  desc = 'Lazy',
                  action = ':Lazy',
                  enabled = package.loaded.lazy ~= nil,
               },
               {
                  icon = ' ',
                  key = 'M',
                  desc = 'Mason',
                  action = ':Mason',
                  ---@param _ snacks.dashboard.Opts
                  enabled = function(_)
                     return Snacks.dashboard.have_plugin('mason.nvim')
                  end,
               },
               { icon = ' ', key = 'q', desc = 'Quit', action = ':qa' },
            },
         },
         formats = {
            header = { '%s', hl = 'Type', align = 'center' },
         },
         sections = {
            { section = 'header' },
            { section = 'keys', gap = 1, padding = 1 },
            { section = 'startup' },
         },
      },
   },
   config = function(_, opts)
      require('snacks').setup(opts)
      --- Show a notification with a pretty printed dump of the object(s)
      --- with lua treesitter highlighting and the location of the caller
      --- ---
      --- Override print to use snacks for `:=` command
      _G.dd = function(...)
         Snacks.debug.inspect(...)
      end
      vim.print = _G.dd

      --- Show a notification with a pretty backtrace
      _G.bt = function()
         Snacks.debug.backtrace()
      end
   end,
}
