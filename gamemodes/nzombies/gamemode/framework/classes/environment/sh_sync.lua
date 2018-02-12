-- Data from the server to sync
local function dataToSync()
	local data = {
		currentEnvironment = nz.Framework.Environment:get()
	}

	return data
end

-- On Client Recieveing
local function onReceive(requestData)
	local currentEnvironmentNumber = requestData["currentEnvironment"]
	-- Sync the data to this client
	nz.Framework.Environment:set(currentEnvironmentNumber)
end

nz.Framework.createSync("Environment", onReceive, dataToSync)
