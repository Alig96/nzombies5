local createEntityRequest = {}

createEntityRequest.id = "CreateEntity"

function createEntityRequest:onReceive(requestingPlayer, requestData)
	-- Send the requst to the controller
	local status = gel.fw:handleController("CreateEntity", requestingPlayer, requestData)
	-- Notify the requesting player if the status of their request passed or not
end

gel.fw:newRequest(createEntityRequest)
