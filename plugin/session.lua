local session_group = augroup('csipa-session', { clear = true })

vim.g.session = {
   auto_save = true,
   load_local = true,
   path = vim.fn.expand(vim.fn.stdpath('data') .. '/sessions/'),
}

---@param event string|'SavePost'|'SavePre'|'LoadPost'|'LoadPre'
local function fire_event(event)
   vim.api.nvim_exec_autocmds('User', {
      group = session_group,
      pattern = 'Session' .. event,
   })
end

local notif = require('fidget.notification')
notif.set_config('session', {
   name = 'Session',
   icon = '❰❰',
   ttl = 8,
}, true)

local function save_session()
   fire_event('SavePre')
   vim.cmd('silent! mksession! .session.vim')
   vim.cmd('sleep 10m')
   fire_event('SavePost')
end

local function load_session(session_file)
   session_file = session_file
      or vim.fn.expand(vim.fn.getcwd() .. '/.session.vim')
   fire_event('LoadPre')
   vim.cmd('silent! source ' .. session_file)
   fire_event('LoadPost')
end

vim.api.nvim_create_user_command(
   'SessionSave',
   save_session,
   { desc = 'Save session' }
)

vim.api.nvim_create_user_command('SessionLoad', function(params)
   load_session(params.args[1])
end, { desc = 'Load session', nargs = '?' })

autocmd('VimEnter', {
   nested = true,
   desc = 'Automatic session load if no arguments have been passed',
   group = session_group,
   callback = function()
      local session_file = vim.fn.expand(vim.fn.getcwd() .. '/.session.vim')
      if vim.fn.argc() > 0 then
         return
      end
      if
         not vim.g.session.load_local
         or vim.fn.filereadable(session_file) == 0
      then
         -- Snacks.dashboard.open()
         return
      end
      load_session(session_file)
   end,
})

autocmd('VimLeavePre', {
   desc = 'Automatic session save before exiting',
   group = session_group,
   callback = function()
      if not vim.g.session.auto_save or vim.v.this_session == '' then
         return
      end
      save_session()
   end,
})

autocmd('User', {
   pattern = 'SessionSavePost',
   desc = 'Notify user the session is saved',
   group = session_group,
   callback = function()
      vim.notify(
         vim.fn.getcwd(),
         vim.log.levels.INFO,
         { group = 'session', annote = 'Saved' }
      )
   end,
})

autocmd('User', {
   pattern = 'SessionLoadPost',
   desc = 'Notify user the session is loaded',
   group = session_group,
   callback = function()
      vim.notify(
         vim.fn.getcwd(),
         vim.log.levels.INFO,
         { group = 'session', annote = 'Loaded' }
      )
   end,
})
