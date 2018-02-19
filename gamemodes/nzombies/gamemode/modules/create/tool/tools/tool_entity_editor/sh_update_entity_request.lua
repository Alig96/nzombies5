local updateEntityRequest = {}

updateEntityRequest.id = "UpdateEntity"

function updateEntityRequest:onReceive(requestingPlayer, requestData)
	-- Send the requst to the controller
	local status = gel.fw:handleController("UpdateEntity", requestingPlayer, requestData)
	-- Notify the requesting player if the status of their request passed or not
end

gel.fw:newRequest(updateEntityRequest.id, updateEntityRequest.onReceive)