local function onReceive(requestingPlayer, requestData)
	-- Send the requst to the controller
	local status = nz.Create.Spawn.handleDeletePlayerSpawner(requestingPlayer, requestData)
end

nz.Framework.createRequest("DeletePlayerSpawner", onReceive)
