local notify_opts = { group = 'Observer' }

---@class Observer
---@field filename string
---@field event uv_fs_event_t
---@field callback function
local Observer = {}

---@param filename string
---@param callback function
function Observer:new(filename, callback)
	local event, err, err_msg = vim.uv.new_fs_event()
	if event == nil then
		vim.notify(err .. ': ' .. err_msg, vim.log.levels.ERROR, notify_opts)
		return
	end

	local t = setmetatable({}, { __index = Observer, __call = Observer.new })
	t.event = event
	t.filename = vim.fn.fnamemodify(filename, ':p')
	t.callback = callback

	return t
end

---@param err string|nil
---@param filename string
---@param status table
function Observer:on_change(err, filename, status)
	dd(status)
	if err then
		vim.notify(err, vim.log.levels.ERROR, notify_opts)
	end
	self.callback(self.event)
	self.event:stop()
	self:watch_file(filename)
end

---@param filename string
function Observer:watch_file(filename)
	if not vim.fs.find(filename, { type = 'file' }) then
		vim.notify(
			'No file found to be watched!',
			vim.log.levels.ERROR,
			notify_opts
		)
		return
	end
	self.filename = filename
	self.event:start(
		filename,
		{},
		vim.schedule_wrap(function(...)
			self:on_change(...)
		end)
	)
end

function Observer:start()
	self:watch_file(self.filename)
end

function Observer:stop()
	self.event:stop()
end

return Observer
