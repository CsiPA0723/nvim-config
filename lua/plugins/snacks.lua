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

---@type LazyPluginSpec[]
return {
   {
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
                     icon = ' ',
                     key = 'f',
                     desc = 'Find File',
                     action = ":lua Snacks.dashboard.pick('files')",
                  },
                  {
                     icon = ' ',
                     key = 'e',
                     desc = 'New File',
                     action = ':ene | startinsert',
                  },
                  {
                     icon = '󰊄 ',
                     key = 'g',
                     desc = 'Live Grep',
                     action = ":lua Snacks.dashboard.pick('live_grep')",
                  },
                  {
                     icon = ' ',
                     key = 'z',
                     desc = 'Zoxide',
                     action = ":lua Snacks.dashboard.pick('zoxide')",
                  },
                  {
                     icon = ' ',
                     key = 'c',
                     desc = 'Config',
                     action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
                  },
                  {
                     icon = ' ',
                     key = 'r',
                     desc = 'Restore last session',
                     section = 'session',
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
               {
                  pane = 2,
                  section = 'terminal',
                  cmd = 'colorscript -e square',
                  height = 5,
                  padding = 1,
               },
               { section = 'keys', gap = 1, padding = 1 },
               {
                  pane = 2,
                  icon = ' ',
                  title = 'Recent Files',
                  section = 'recent_files',
                  indent = 2,
                  padding = 1,
               },
               {
                  pane = 2,
                  icon = ' ',
                  title = 'Projects',
                  section = 'projects',
                  indent = 2,
                  padding = 1,
               },
               {
                  pane = 2,
                  icon = ' ',
                  title = 'Git Status',
                  section = 'terminal',
                  enabled = function()
                     return Snacks.git.get_root() ~= nil
                  end,
                  cmd = 'git status --short --branch --renames',
                  height = 5,
                  padding = 1,
                  ttl = 5 * 60,
                  indent = 3,
               },
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
   },
}
