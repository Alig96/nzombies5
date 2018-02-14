local realmLoader = {}

function realmLoader:determineRealm(fileName)
	local sep = string.Explode("_", fileName)

	-- If the file is a server file;
	if sep[1] == "sv" then
		return "sv"
	end

	-- If the file is a shared file;
	if sep[1] == "sh" then
		return "sh"
	end

	-- If the file is a client file;
	if sep[1] == "cl" then
		return "cl"
	end

	-- The file is incompatible
	Log(LOG_ERROR, "Could not determine realm of: " .. fileName, "Framework:Loader")
	return null
end

function realmLoader:include(currentDir, fileName)
	-- Get the realm code
	local realmCode = self:determineRealm(fileName)
	-- Build the full path
	local fullPath = currentDir .. '/' .. fileName

	-- Determine where to load the files
	if realmCode == "sv" then
		if SERVER then
			print("Including: " .. fullPath)
			include(fullPath)
		end
	elseif realmCode == "sh" then
		if SERVER then
			print("Sending: " .. fullPath)
			AddCSLuaFile(fullPath)
			print("Including: " .. fullPath)
			include(fullPath)
		elseif CLIENT then
			print("Including: " .. fullPath)
			include(fullPath)
		end
	elseif realmCode == "cl" then
		if SERVER then
			print("Sending: " .. fullPath)
			AddCSLuaFile(fullPath)
		elseif CLIENT then
			print("Including: " .. fullPath)
			include(fullPath)
		end
	end
end

function realmLoader:recursiveInclude(currentDirectory)
	-- Scan through the current directory, include any files, and then re run self for any directorys
	local loadFiles, loadFolders = file.Find(currentDirectory .. "/*", "LUA")

	-- If we have a models folder, load that first
	if table.HasValue(loadFolders, "models") then
		print("Priortising the models directory: " .. currentDirectory .. "/" .. "models")
		self:recursiveInclude(currentDirectory .. "/" .. "models")
	end

	if loadFiles != null then
		-- Check for a constructor module file
		if table.HasValue(loadFiles, "sh_constructor.lua") then
			print("Module: " .. currentDirectory)
			self:include(currentDirectory, "sh_constructor.lua")
		end

		for k, loadFile in pairs(loadFiles) do
			-- We don't need to reload the constructor, since we loaded it first
			if loadFile != "sh_constructor.lua" then
				self:include(currentDirectory, loadFile)
			end
		end
	end

	if loadFolders != null then
		for k, loadFolder in pairs(loadFolders) do
			-- We don't need to reload the constructor, since we loaded it first
			if loadFolder != "models" then
				self:recursiveInclude(currentDirectory .. "/" .. loadFolder)
			end
		end
	end

end

function realmLoader:loadDirectory(includeDir)
	print("Realm Loading: " .. includeDir)

	-- Run self on both client and server
	if SERVER then
		print(" ** Server List **")
	elseif CLIENT then
		print(" ** Client List **")
	end

	-- Recursively include everything with the module directorys
	self:recursiveInclude(includeDir)

	print(" ** End List **")
	hook.Run("realmLoader.Finished", includeDir)
end

-- Assign the table to the global
gel.Internal.Loader = realmLoader

-- Create shortcut
function gel.fw:loadDirectory(includeDir)
	gel.Internal.Loader:loadDirectory(includeDir)
end
