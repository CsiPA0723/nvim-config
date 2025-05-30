local Job = require('plenary.job')
local notif_group = 'mpris'

local notify = vim.schedule_wrap(vim.notify)

local on_stderr = function(error, data, _)
   error = error or 'Error'
   data = data or 'Unknown error'
   notify(error .. '\n' .. data, vim.log.levels.ERROR, { group = notif_group })
end

local M = {
   enabled = true,
   title = 'Unknown',
   artist = 'Unknown',
   track = 'Unknown - Unknown',
   lualine_component = 'Unknown - Unknown',
   playing = false,
   changed_song = false,
   media_players = { 'tidal-hifi', 'strawberry', 'spotify' },
}

function M.setup()
   require('fidget.notification').set_config(notif_group, {
      name = 'Media',
      icon = ' ',
      ttl = 4,
   }, true)

   ---@diagnostic disable-next-line: missing-fields
   M.job_metadata = Job:new({
      command = 'playerctl',
      args = {
         '--all-players',
         '--player',
         table.concat(M.media_players, ','),
         '--follow',
         'metadata',
      },
      on_stderr = on_stderr,
      on_stdout = function(error, data, self)
         if error then
            on_stderr(error, nil, self)
         end
         local artist = string.match(data, '%s+xesam:artist%s+(.*)')
         local title = string.match(data, '%s+xesam:title%s+(.*)')

         if nil == M.artist or artist ~= M.artist and nil ~= artist then
            M.artist = artist or M.artist
            M.changed_song = true
         end
         if nil == M.title or title ~= M.title and nil ~= title then
            M.title = title or M.title
            M.changed_song = true
         end
      end,
   })
   M.job_metadata:start()

   ---@diagnostic disable-next-line: missing-fields
   M.job_status = Job:new({
      command = 'playerctl',
      args = {
         '--all-players',
         '--player',
         table.concat(M.media_players, ','),
         '--follow',
         'status',
      },
      on_stderr = on_stderr,
      on_stdout = function(error, data, self)
         if error then
            on_stderr(error, nil, self)
         end
         M.playing = data == 'Playing'
      end,
   })
   M.job_status:start()

   local track_index = 1
   local direction = 1
   local wait = false

   vim.fn.timer_start(500, function(_)
      local max_size = math.floor(vim.o.columns / 3) - 1
      if vim.o.columns < 90 and M.enabled then
         M.enabled = false
         return
      elseif vim.o.columns >= 90 then
         M.enabled = true
      end

      if M.changed_song then
         track_index = 1
         direction = 1
         M.track = (M.artist or 'Unknown') .. ' - ' .. (M.title or 'Unknown')
         M.changed_song = false
      end

      local str = M.track

      if #M.track > max_size then
         str = string.sub(str, track_index, max_size + track_index)

         if not wait then
            track_index = track_index + direction
         else
            wait = false
         end

         if track_index <= 0 or track_index + max_size > #M.track then
            if track_index <= 0 then
               track_index = 1
            else
               track_index = #M.track - max_size
            end
            direction = direction * -1
            wait = true
         end
      end

      M.lualine_component = '  ' .. str .. '  '
   end, { ['repeat'] = -1 })
end

function M.get_status()
   return M.playing and M.enabled
end

function M.lualine()
   return M.lualine_component
end

return M
