local function onReceive(requestingPlayer, requestData)
	-- Send the requst to the controller
	local status = nz.Create.Spawn.handleCreatePlayerSpawner(requestingPlayer, requestData)
end

nz.Framework.createRequest("CreatePlayerSpawner", onReceive)
