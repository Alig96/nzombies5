local createPlayerSpawnerRequest = {}

createPlayerSpawnerRequest.id = "CreatePlayerSpawner"

function createPlayerSpawnerRequest:onReceive(requestingPlayer, requestData)
	-- Send the requst to the controller
	local status = gel.fw:handleController("CreatePlayerSpawner", requestingPlayer, requestData)
	-- Notify the requesting player if the status of their request passed or not
end

gel.fw:newRequest(createPlayerSpawnerRequest.id, createPlayerSpawnerRequest.onReceive)
