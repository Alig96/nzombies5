-- On Client Recieveing
local function onReceive(requestData)
	local currentModeNumber = requestData["currentMode"]
	-- Sync the data to this client
	nz.Mode:set(currentModeNumber)
end

-- Data from the server to sync
local function dataToSync()
	local data = {
		currentMode = nz.Mode:get()
	}

	return data
end

nz.Framework.createSync("Mode", onReceive, dataToSync)
