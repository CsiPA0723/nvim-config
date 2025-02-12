--- Create a flat list of all files in a directory
--
--- @reference https://gist.github.com/imliam/7a5ed398531a6338081a7f3c25c934fb
--
--- @param directory string? The directory to scan (default value = './')
--- @param recursive boolean? Whether or not to scan subdirectories recursively (default value = true)
--- @param grep string? Regex filtering for the listing with grep
local function scandir(directory, recursive, grep)
	directory = directory or ''
	recursive = recursive or false
	local currentDirectory = directory
	local fileList = {}
	local command = 'ls ' .. currentDirectory .. ' -I "*node_modules*" -p'

	if recursive then
		command = command .. 'R'
	end

	if type(grep) == 'string' then
		command = command .. ' | grep -iE "' .. grep .. '"'
	end

	for fileName in io.popen(command):lines() do
		if string.sub(fileName, -1) == '/' then
			-- Directory, don't do anything
		elseif string.sub(fileName, -1) == ':' then
			currentDirectory = string.sub(fileName, 1, -2)
			currentDirectory = currentDirectory .. '/'
		elseif string.len(fileName) == 0 then
			-- Blank line
			currentDirectory = directory
		else
			table.insert(fileList, currentDirectory .. fileName)
		end
	end

	return fileList
end

return scandir
