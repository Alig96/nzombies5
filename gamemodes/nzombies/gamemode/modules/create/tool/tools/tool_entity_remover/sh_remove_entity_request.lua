local removeEntityRequest = {}

removeEntityRequest.id = "RemoveEntity"

function removeEntityRequest:onReceive(requestingPlayer, requestData)
	-- Send the requst to the controller
	local status = gel.fw:handleController("RemoveEntity", requestingPlayer, requestData)
	-- Notify the requesting player if the status of their request passed or not
end

gel.fw:newRequest(removeEntityRequest)
