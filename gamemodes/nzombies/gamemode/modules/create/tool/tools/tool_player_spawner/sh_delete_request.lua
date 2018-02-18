local deletePlayerSpawnerRequest = {}

deletePlayerSpawnerRequest.id = "DeletePlayerSpawner"

function deletePlayerSpawnerRequest:onReceive(requestingPlayer, requestData)
	-- Send the requst to the controller
	local status = gel.fw:handleController("DeletePlayerSpawner", requestingPlayer, requestData)
	-- Notify the requesting player if the status of their request passed or not
end

gel.fw:newRequest(deletePlayerSpawnerRequest.id, deletePlayerSpawnerRequest.onReceive)
