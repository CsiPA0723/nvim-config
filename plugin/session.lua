local session_group = augroup('csipa-session', { clear = true })

local H = {}

vim.g.session = {
   auto_save = true,
   load_local = true,
   path = vim.fn.expand(vim.fn.stdpath('data') .. '/sessions/'),
}

local notif = require('fidget.notification')
notif.set_config('session', {
   name = 'Session',
   icon = '❰❰',
   ttl = 8,
}, true)

vim.api.nvim_create_user_command('SessionSave', function()
   H.save_session()
end, { desc = 'Save session' })

vim.api.nvim_create_user_command('SessionLoad', function(params)
   H.load_session(params.args[1])
end, { desc = 'Load session', nargs = '?' })

autocmd('VimEnter', {
   nested = true,
   desc = 'Automatic session load if no arguments have been passed',
   group = session_group,
   callback = function()
      local session_file = vim.fn.expand(vim.fn.getcwd() .. '/.session.vim')
      if
         not vim.g.session.load_local
         or vim.fn.filereadable(session_file) == 0
      then
         -- Snacks.dashboard.open()
         return
      end
      if H.is_something_shown() then
         return
      end
      H.load_session(session_file)
   end,
})

autocmd('VimLeavePre', {
   desc = 'Automatic session save before exiting',
   group = session_group,
   callback = function()
      if not vim.g.session.auto_save or vim.v.this_session == '' then
         return
      end
      H.save_session()
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

---@param event string|'SavePost'|'SavePre'|'LoadPost'|'LoadPre'
function H.fire_event(event)
   vim.api.nvim_exec_autocmds('User', {
      group = session_group,
      pattern = 'Session' .. event,
   })
end

function H.save_session()
   H.fire_event('SavePre')
   vim.cmd('silent! mksession! .session.vim')
   vim.cmd('sleep 10m') -- 10 milliseconds
   H.fire_event('SavePost')
end

function H.load_session(session_file)
   session_file = session_file
      or vim.fn.expand(vim.fn.getcwd() .. '/.session.vim')
   H.fire_event('LoadPre')
   vim.cmd('silent! source ' .. session_file)
   H.fire_event('LoadPost')
end

-- NOTE: Credit to mini.sessions
function H.is_something_shown()
   -- Don't autoread session if Neovim is opened to show something. That is
   -- when at least one of the following is true:
   -- - There are files in arguments (like `nvim foo.txt` with new file).
   if vim.fn.argc() > 0 then
      return true
   end

   -- - Several buffers are listed (like session with placeholder buffers). That
   --   means unlisted buffers (like from `nvim-tree`) don't affect decision.
   local listed_buffers = vim.tbl_filter(function(buf_id)
      return vim.fn.buflisted(buf_id) == 1
   end, vim.api.nvim_list_bufs())
   if #listed_buffers > 1 then
      return true
   end

   -- - Current buffer is meant to show something else
   if vim.bo.filetype ~= '' then
      return true
   end

   -- - Current buffer has any lines (something opened explicitly).
   -- NOTE: Usage of `line2byte(line('$') + 1) < 0` seemed to be fine, but it
   -- doesn't work if some automated changed was made to buffer while leaving it
   -- empty (returns 2 instead of -1). This was also the reason of not being
   -- able to test with child Neovim process from 'tests/helpers'.
   local n_lines = vim.api.nvim_buf_line_count(0)
   if n_lines > 1 then
      return true
   end
   local first_line = vim.api.nvim_buf_get_lines(0, 0, 1, true)[1]
   if string.len(first_line) > 0 then
      return true
   end

   return false
end
