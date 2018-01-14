Loader = {}
Loader.__index = Loader

function Loader:determineRealm( fileName )
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
	print("Could not determine realm of: " .. fileName)
	return null
end

function Loader:include( currentDir, fileName )
	-- Get the realm code
	local realmCode = self:determineRealm( fileName )
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
			include(fullPath)
		end
	elseif realmCode == "cl" then
		if SERVER then
			print("Sending: " .. fullPath)
			AddCSLuaFile(fullPath)
		else
			print("Including: " .. fullPath)
			include(fullPath)
		end
	end
end

function Loader:recursiveInclude( currentPath )
	-- Scan through the current directory, include any files, and then re run self for any directorys
	local loadFiles, loadFolders = file.Find(currentPath .. "/*", "LUA")

	if loadFiles != null then
		-- Check for a constructor module file
		if table.HasValue(loadFiles, "sh_constructor.lua") then
			print("Constructing: " .. currentPath)
			self:include(currentPath, "sh_constructor.lua")
		end

		for k, loadFile in pairs(loadFiles) do
			-- We don't need to reload the constructor, since we loaded it first
			if loadFile != "sh_constructor" then
				self:include(currentPath, loadFile)
			end
		end
	end

	if loadFolders != null then
		for k, loadFolder in pairs(loadFolders) do
			self:recursiveInclude(currentPath .. "/" .. loadFolder)
		end
	end

end

function Loader:new( includeDir )
	print("********************")
	print("Realm Loading: " .. includeDir)
	print("--------------------")

	-- Run self on both client and server
	if SERVER then
		print(" ** Server List **")
	elseif CLIENT then
		print(" ** Client List **")
	end

	-- Scan through the given directory
	local _, initDirs = file.Find(includeDir, "LUA")

	-- Remove the astrix from the include directory
	local basePath = includeDir:gsub("*", "")

	-- Recursively include everything with the module directorys
	for _, moduleFolder in pairs(initDirs) do
		self:recursiveInclude(basePath .. moduleFolder)
	end

	print(" ** End List **")
	print("********************")
	hook.Call( "RealmLoader.Finished" )
end

setmetatable( Loader, { __call = Loader.new } )
